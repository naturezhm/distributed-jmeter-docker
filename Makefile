build:
	@docker build  --build-arg JMETER_VERSION=5.2.1 -t bradyzm/jmeter-docker:local -f Dockerfile_new .

# build_all:
# 	@while read -r version ; do \
# 		docker build --build-arg JMETER_VERSION=$$version --tag bradyzm/jmeter-docker:$$version . ; \
# 		docker push bradyzm/jmeter-docker:$$version ; \
# 	done < VERSIONS

build_old:
	@while read -r version ; do \
		docker build --build-arg JMETER_VERSION=$$version --tag bradyzm/jmeter-docker:$$version -f Dockerfile .; \
		docker push bradyzm/jmeter-docker:$$version ; \
	done < VERSIONS_OLD


build_new:
	@while read -r version ; do \
		docker build --build-arg JMETER_VERSION=$$version --tag bradyzm/jmeter-docker:$$version -f Dockerfile_new . ; \
		docker push bradyzm/jmeter-docker:$$version ; \
	done < VERSIONS_NEW