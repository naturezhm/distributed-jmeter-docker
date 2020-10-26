build:
	@docker build  --build-arg JMETER_VERSION=5.2.1 -t bradyzm/jmeter-docker:local -f new.Dockerfile .

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
		docker build --build-arg JMETER_VERSION=$$version --tag bradyzm/jmeter-docker:$$version -f new.Dockerfile . ; \
		docker push bradyzm/jmeter-docker:$$version ; \
	done < VERSIONS_NEW

helm_package:
	mkdir -p dist
	helm package k8s distributed-jmeter-5.2.1.tgz
	mv distributed-jmeter-5.2.1.tgz dist
