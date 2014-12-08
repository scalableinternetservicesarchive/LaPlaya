import subprocess
import sys

serverURL = None

# grab URL from stdin
if len(sys.argv) >= 2:
    serverURL = sys.argv[1]

# test cases, one array entry per test (may be multiple entries per class/file)
tests = [
    { "test_CPCreateUser.py", "CPCreateUser", "test_logged_out_signup_path", "cp-createuser-bench.xml" },
    { "test_CPComments.py", "CPComments", "test_readonly_view_comment", "cp-comments-bench.xml" },
    { "test_CPShowProjects.py", "CPShowProjects", "test_readonly_view_projects", "cp-showprojects-bench.xml" },
    { "test_CPHearts.py", "CPHearts", "test_heart_projects", "cp-hearts-bench.xml" }
    ]

# run tests
for test in tests:
    cmdLine = ""
    if serverURL = None:
        cmdLine = 'fl-run-bench %s %s.%s' % (test[0], test[1], test[2])
    else:
        cmdLine = 'fl-run-bench -u %s %s.%s' % (serverURL, test[0], test[1], test[2])

    subprocess.call([cmdLine])

# create reports
for test in tests:
    cmdLine = 'fl-build-report --html %s' % (test[3])

    subprocess.call([cmdLine])

print "Testing complete."