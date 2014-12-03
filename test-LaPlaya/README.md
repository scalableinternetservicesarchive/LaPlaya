# Load Testing

This directory contains the load testing files for our project. We can have tests that evaluate the performance of a specific path within our application (such as user creation), and we can have tests that evaluate a series of actions (such as user login, view projects, create comment, view gallery).

Each test file is named `test_<something>.py` has a corresponding configuration file `<something>.conf`. The configuration file can contain metadata used by the tests, as well as funkload configuration info for running the benchmarks. 

## How to run

To run *just* the tests

```
fl-run-test test_<something>.py
```

To run the performance benchmarks

```
fl-run-bench test_<something>.py <Class_name>.<test_case>
```

**After** running benchmarks, to generate the HTML report

```
fl-build-report --html <testname>-bench.xml
```

## Deployment

When generating actual data that we want to record, we should run funkload on AWS. Use the funkload Cloud Formation template for this purpose. 

**Remember** to update the URL's in the `*.conf` files when we create new application stacks as well

## Cleanup

Funkload generates a lot of files which could make this directory very crowded. When you run the tests/benchmarks multiple times it creates backups of previous xml files. To cleanup these, and only keep the most recent xml files, use `sh clean_backups.sh`. To clean up all artifacts, and only keep our test and conf files, use `sh clean_all.sh`, but **do not do this until AFTER you have generated any reports**. You need the xml files for that.
