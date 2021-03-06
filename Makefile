#!/usr/bin/make

all: lint unit_test


.PHONY: apt_prereqs
apt_prereqs:
	@# Need tox, but don't install the apt version unless we have to (don't want to conflict with pip)
	@which tox >/dev/null || sudo apt-get install -y python-pip && sudo pip install tox

lint: apt_prereqs
	@tox --notest
	@PATH=`pwd`/.tox/py34/bin:`pwd`/.tox/py35/bin flake8 $(wildcard hooks reactive lib unit_tests tests)
	@charm proof

unit_test: apt_prereqs
	@echo Starting tests...
	tox