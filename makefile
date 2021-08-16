.PHONY: Collatz.log

FILES :=                              \
    Collatz.html                      \
    Collatz.log                       \
    Collatz.py                        \
    RunCollatz.in                     \
    RunCollatz.out                    \
    RunCollatz.py                     \
    TestCollatz.out                   \
    TestCollatz.py

#    collatz-tests/YourGitLabID-RunCollatz.in   \
#    collatz-tests/YourGitLabID-RunCollatz.out  \
#    collatz-tests/YourGitLabID-TestCollatz.out \
#    collatz-tests/YourGitLabID-TestCollatz.py  \
#

collatz-tests:
	git clone https://gitlab.com/fareszf/cs330e-collatz-tests.git

Collatz.html: Collatz.py
	pydoc3 -w Collatz

Collatz.log:
	git log > Collatz.log

RunCollatz.tmp: RunCollatz.in RunCollatz.out RunCollatz.py
	python RunCollatz.py < RunCollatz.in > RunCollatz.tmp
	diff --strip-trailing-cr RunCollatz.tmp RunCollatz.out

TestCollatz.tmp: TestCollatz.py
	coverage run    --branch TestCollatz.py >  TestCollatz.tmp 2>&1
	coverage report -m                      >> TestCollatz.tmp
	cat TestCollatz.tmp

check:
	@not_found=0;                                 \
    for i in $(FILES);                            \
    do                                            \
        if [ -e $$i ];                            \
        then                                      \
            echo "$$i found";                     \
        else                                      \
            echo "$$i NOT FOUND";                 \
            not_found=`expr "$$not_found" + "1"`; \
        fi                                        \
    done;                                         \
    if [ $$not_found -ne 0 ];                     \
    then                                          \
        echo "$$not_found failures";              \
        exit 1;                                   \
    fi;                                           \
    echo "success";

clean:
	rm -f  .coverage
	rm -f  *.pyc
	rm -f  RunCollatz.tmp
	rm -f  TestCollatz.tmp
	rm -rf __pycache__
	rm -rf cs330e-collatz-tests
	
config:
	git config -l

format:
	autopep8 -i Collatz.py
	autopep8 -i RunCollatz.py
	autopep8 -i TestCollatz.py

scrub:
	make clean
	rm -f  Collatz.html
	rm -f  Collatz.log
	rm -rf collatz-tests

status:
	make clean
	@echo
	git branch
	git remote -v
	git status
	
versions:
	which     autopep8
	autopep8 --version
	@echo
	which    coverage
	coverage --version
	@echo
	which    git
	git      --version
	@echo
	which    make
	make     --version
	@echo
	which    pip3
	pip      --version
	@echo
#	which    pydoc3
#	pydoc    --version
#	@echo
	which    pylint
	pylint   --version
	@echo
	which    python3
	python   --version

test: Collatz.html Collatz.log RunCollatz.tmp TestCollatz.tmp collatz-tests check
