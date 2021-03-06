~/dev/spark/current/bin/spark-submit \
    --driver-library-path /opt/cloudera/parcels/CDH/lib/hadoop/lib/native   \
    --master yarn \
    --deploy-mode client   \
    --num-executors 128 \
    --executor-memory 2g    \
    --driver-memory 6g     \
    --conf spark.driver.maxResultSize=8192m \
    --class edu.umd.cs.hcil.analytics.spark.topics.reddit.RedditTopicModeler \
    /cliphomes/cbuntain/Development/CrossPlatformAnalytics/target/CrossPlatformAnalytics-1.0-SNAPSHOT-jar-with-dependencies.jar \
    -i '/user/cbuntain/reddit/RS_2016-06.bz2' \
    -o topic_models/reddit_201606_$TOPIC_COUNT \
    -s ~/stops.txt \
    -t $TOPIC_COUNT \
    -i 128 \
    --mintf 1 \
    --mindf 1000 \
    -p 256


~/dev/spark/current/bin/spark-submit \
    --driver-library-path /opt/cloudera/parcels/CDH/lib/hadoop/lib/native   \
    --master yarn \
    --deploy-mode client   \
    --num-executors 128 \
    --executor-memory 2g    \
    --driver-memory 6g     \
    --conf spark.driver.maxResultSize=8192m \
    --class edu.umd.cs.hcil.analytics.spark.topics.reddit.RedditTopicModeler \
    /cliphomes/cbuntain/Development/CrossPlatformAnalytics/target/CrossPlatformAnalytics-1.0-SNAPSHOT-jar-with-dependencies.jar \
    -i '/user/cbuntain/reddit/RS_2016-07.bz2' \
    -o topic_models/reddit_201607_$TOPIC_COUNT \
    -s ~/stops.txt \
    -t $TOPIC_COUNT \
    -i 128 \
    --mintf 1 \
    --mindf 1000 \
    -p 256

~/dev/spark/current/bin/spark-submit \
    --driver-library-path /opt/cloudera/parcels/CDH/lib/hadoop/lib/native   \
    --master yarn \
    --deploy-mode client   \
    --num-executors 128 \
    --executor-memory 2g    \
    --driver-memory 6g     \
    --conf spark.driver.maxResultSize=8192m \
    --class edu.umd.cs.hcil.analytics.spark.topics.reddit.RedditTopicModeler \
    /cliphomes/cbuntain/Development/CrossPlatformAnalytics/target/CrossPlatformAnalytics-1.0-SNAPSHOT-jar-with-dependencies.jar \
    -i '/user/cbuntain/reddit/RS_2016-08.bz2' \
    -o topic_models/reddit_201608_$TOPIC_COUNT \
    -s ~/stops.txt \
    -t $TOPIC_COUNT \
    -i 128 \
    --mintf 1 \
    --mindf 1000 \
    -p 256


~/dev/spark/current/bin/spark-submit \
    --driver-library-path /opt/cloudera/parcels/CDH/lib/hadoop/lib/native   \
    --master yarn \
    --deploy-mode client   \
    --num-executors 128 \
    --executor-memory 2g    \
    --driver-memory 6g     \
    --conf spark.driver.maxResultSize=8192m \
    --class edu.umd.cs.hcil.analytics.spark.topics.reddit.RedditTopicModeler \
    /cliphomes/cbuntain/Development/CrossPlatformAnalytics/target/CrossPlatformAnalytics-1.0-SNAPSHOT-jar-with-dependencies.jar \
    -i '/user/cbuntain/reddit/RS_2016-09.bz2' \
    -o topic_models/reddit_201609_$TOPIC_COUNT \
    -s ~/stops.txt \
    -t $TOPIC_COUNT \
    -i 128 \
    --mintf 1 \
    --mindf 1000 \
    -p 256


~/dev/spark/current/bin/spark-submit \
    --driver-library-path /opt/cloudera/parcels/CDH/lib/hadoop/lib/native   \
    --master yarn \
    --deploy-mode client   \
    --num-executors 128 \
    --executor-memory 2g    \
    --driver-memory 6g     \
    --conf spark.driver.maxResultSize=8192m \
    --class edu.umd.cs.hcil.analytics.spark.topics.reddit.RedditTopicModeler \
    /cliphomes/cbuntain/Development/CrossPlatformAnalytics/target/CrossPlatformAnalytics-1.0-SNAPSHOT-jar-with-dependencies.jar \
    -i '/user/cbuntain/reddit/RS_2016-10.bz2' \
    -o topic_models/reddit_201610_$TOPIC_COUNT \
    -s ~/stops.txt \
    -t $TOPIC_COUNT \
    -i 128 \
    --mintf 1 \
    --mindf 1000 \
    -p 256


~/dev/spark/current/bin/spark-submit \
    --driver-library-path /opt/cloudera/parcels/CDH/lib/hadoop/lib/native   \
    --master yarn \
    --deploy-mode client   \
    --num-executors 128 \
    --executor-memory 2g    \
    --driver-memory 6g     \
    --conf spark.driver.maxResultSize=8192m \
    --class edu.umd.cs.hcil.analytics.spark.topics.reddit.RedditTopicModeler \
    /cliphomes/cbuntain/Development/CrossPlatformAnalytics/target/CrossPlatformAnalytics-1.0-SNAPSHOT-jar-with-dependencies.jar \
    -i '/user/cbuntain/reddit/RS_2016-11.bz2' \
    -o topic_models/reddit_201611_$TOPIC_COUNT \
    -s ~/stops.txt \
    -t $TOPIC_COUNT \
    -i 128 \
    --mintf 1 \
    --mindf 1000 \
    -p 256


~/dev/spark/current/bin/spark-submit \
    --driver-library-path /opt/cloudera/parcels/CDH/lib/hadoop/lib/native   \
    --master yarn \
    --deploy-mode client   \
    --num-executors 128 \
    --executor-memory 2g    \
    --driver-memory 6g     \
    --conf spark.driver.maxResultSize=8192m \
    --class edu.umd.cs.hcil.analytics.spark.topics.reddit.RedditTopicModeler \
    /cliphomes/cbuntain/Development/CrossPlatformAnalytics/target/CrossPlatformAnalytics-1.0-SNAPSHOT-jar-with-dependencies.jar \
    -i '/user/cbuntain/reddit/RS_2016-12.bz2' \
    -o topic_models/reddit_201612_$TOPIC_COUNT \
    -s ~/stops.txt \
    -t $TOPIC_COUNT \
    -i 128 \
    --mintf 1 \
    --mindf 1000 \
    -p 256
