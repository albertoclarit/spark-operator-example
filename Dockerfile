FROM apache/spark:3.5.5-java17

# Set environment variables
ENV SPARK_HOME=/opt/spark
ENV PATH=$PATH:$SPARK_HOME/bin

# Create directories for our application
RUN mkdir -p /opt/spark/work-dir/jars
RUN mkdir -p /opt/spark/work-dir/running
RUN mkdir -p /opt/spark/work-dir/data
# Copy the application JAR
COPY app/build/libs/*.jar  /opt/spark/work-dir/running/spark-app.jar
#COPY large-file.json  /opt/spark/work-dir/data/large-file.json
COPY flights-1m.parquet  /opt/spark/work-dir/data/flights-1m.parquet

# Copy all dependency JARs
COPY libs/*.jar /opt/spark/work-dir/jars/

# Set the working directory
WORKDIR /opt/spark/work-dir

# The image can be used as follows:
# docker run <image> /opt/spark/bin/spark-submit --class org.example.App app.jar
