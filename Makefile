######################################################
# This is only intended for LOCAL DEVELOPMENT !!!!!! #
######################################################

start: docker run axelor-erp:latest

build: ./gradlew clean && ./gradlew build \
	&& docker build . -t axelor-erp:latest

local: docker run -it -d postgres \
	make build && make start

