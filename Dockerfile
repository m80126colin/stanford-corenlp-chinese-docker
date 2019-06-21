FROM openjdk:11-jre
LABEL Maintainer="Hsu Karinsu <m80126colin@gmail.com>"

ENV STANFORD_SITE http://nlp.stanford.edu/software
ENV NLP_VERSION 3.9.2
ENV NLP_DATE 2018-10-05

RUN apt-get update && \
	apt-get install -y --no-install-recommends unzip wget && \
	wget $STANFORD_SITE/stanford-corenlp-full-$NLP_DATE.zip && \
	unzip stanford-corenlp-full-$NLP_DATE.zip && \
	rm stanford-corenlp-full-$NLP_DATE.zip

WORKDIR /stanford-corenlp-full-$NLP_DATE

RUN wget $STANFORD_SITE/stanford-chinese-corenlp-$NLP_DATE-models.jar

RUN export CLASSPATH="`find . -name '*.jar'`"

EXPOSE 9000

CMD java -mx8g -cp "*" edu.stanford.nlp.pipeline.StanfordCoreNLPServer \
  -serverProperties StanfordCoreNLP-chinese.properties \
	-port 9000 \
	-timeout 315000 \
	-threads 4 \
	-quiet