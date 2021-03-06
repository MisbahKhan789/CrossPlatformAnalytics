package edu.umd.cs.hcil.analytics.spark.temporal.fourchan

import java.text.SimpleDateFormat
import java.util.{Calendar, Date, Locale}

import edu.umd.cs.hcil.analytics.utils.TimeScale
import edu.umd.cs.hcil.models.fourchan.ThreadParser
import edu.umd.cs.hcil.models.reddit.SubmissionParser
import org.apache.spark.rdd.RDD
import org.apache.spark.{SparkConf, SparkContext}

/**
  * Created by cbuntain on 9/19/17.
  */
object Frequency {

  // Twitter's time format'
  def TIME_FORMAT = "EEE MMM d HH:mm:ss Z yyyy"

  /**
    * Print the usage message
    */
  def printHelp() : Unit = {
    println("Usage: spark-submit " + this.getClass.getCanonicalName + "<-m|-h|-d> <input_file> <output_dir> [numPartitions]")
    println("\t -m \t count tweets per minute")
    println("\t -h \t count tweets per hour")
    println("\t -d \t count tweets per day")
  }

  /**
    * @param args the command line arguments
    */
  def main(args: Array[String]): Unit = {

    if ( args.size < 3 ) {
      printHelp()
      sys.exit(1)
    }

    val conf = new SparkConf().setAppName("4chan Thread Frequency")
    val sc = new SparkContext(conf)

    val timeScaleStr = args(0)
    val dataPath = args(1)
    val outputPath = args(2)

    // Validate and set time scale
    var timeScale = TimeScale.MINUTE
    if ( timeScaleStr == "-m" ) {
      timeScale = TimeScale.MINUTE
    } else if ( timeScaleStr == "-h" ) {
      timeScale = TimeScale.HOURLY
    } else if ( timeScaleStr == "-d" ) {
      timeScale = TimeScale.DAILY
    } else {
      printHelp()
      sys.exit(1)
    }

    val messagesRaw = sc.textFile(dataPath)
    println("Initial Partition Count: " + messagesRaw.partitions.size)

    // Repartition if desired using the new partition count
    var messages = messagesRaw
    if ( args.size > 3 ) {
      val initialPartitions = args(3).toInt
      messages = messagesRaw.repartition(initialPartitions)
      println("New Partition Count: " + messages.partitions.size)
    }
    val newPartitionSize = messages.partitions.size

    // Convert each JSON line in the file to a status using Twitter4j
    //  Note that not all lines are Status lines, so we catch any exception
    //  generated during this conversion and set to null since we don't care
    //  about non-status lines.'
    // Convert each JSON line in the file to a submission
    val dataTimes : RDD[Long] = messages.map(line => {

      val thread = ThreadParser.parseJson(line)

      if ( thread != null && thread.posts != null && thread.posts.length > 0 && thread.posts.head != null ) {
        thread.posts.head.time
      } else {
        -1
      }

    }).filter(sub => sub > 0)

    // For each status, create a tuple with its creation time (flattened to the
    //  correct time scale) and a 1 for counting
    val datedData = dataTimes.map(threadTIme => (TimeScale.convertTimeToSlice(new Date(threadTIme * 1000), timeScale), 1))

    // Sum up the counts by date
    val groupedCounts : RDD[Tuple2[Date, Int]] = datedData.reduceByKey((l, r) =>
      l + r
    )

    // Pull out just the times
    val times = groupedCounts.map(tuple => {
      tuple._1
    })

    // Find the min and max times, so we can construct a full list
    val minTime = times.reduce((l, r) => {
      if ( l.compareTo(r) < 1 ) {
        l
      } else {
        r
      }
    })
    println("Min Time: " + minTime)

    val maxTime = times.reduce((l, r) => {
      if ( l.compareTo(r) > 0 ) {
        l
      } else {
        r
      }
    })
    println("Max Time: " + maxTime)

    // Create keys for EACH time between min and max, then parallelize it for
    //  merging with actual data
    //  NOTE: This step likely isn't necessary if we're dealing with the full
    //  1% stream, but filtered streams aren't guarateed to have data in each
    //  time step.
    val fullKeyList = TimeScale.constructDateList(minTime, maxTime, timeScale)
    val fullKeyRdd : RDD[Tuple2[Date, Int]] =
      sc.parallelize(fullKeyList).map(key => (key, 0))

    // Merge the full date list and regular data
    val withFullDates = groupedCounts.union(fullKeyRdd)
    val mergedDates = withFullDates.reduceByKey((l, r) => l + r)

    // Sort for printing
    val sliceCounts = mergedDates.sortByKey()

    // Convert to a CSV string and save
    sliceCounts.map(tuple => {
      TimeScale.dateFormatter(tuple._1) + ", " + tuple._2
    }).saveAsTextFile(outputPath)
  }

}
