FROM apache/spark:3.5.5

# Set environment variables
ENV SPARK_HOME=/opt/spark
ENV PATH=$PATH:$SPARK_HOME/bin

# Create directories for our application
RUN mkdir -p /opt/spark/work-dir/jars

# Copy the application JAR
COPY app/build/libs/app-1.0.0-all.jar /opt/spark/work-dir/

# Copy the dependency JARs
COPY libs/hadoop-aws-3.3.4.jar /opt/spark/work-dir/jars/
COPY libs/hadoop-common-3.3.4.jar /opt/spark/work-dir/jars/
COPY libs/aws-java-sdk-bundle-1.12.262.jar /opt/spark/work-dir/jars/

# Set the working directory
WORKDIR /opt/spark/work-dir

# The image can be used as follows:
# docker run <image> /opt/spark/bin/spark-submit --class org.example.App app-1.0.0-all.jar
