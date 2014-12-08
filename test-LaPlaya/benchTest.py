import subprocess
import sys

serverURL = None

# grab URL from stdin
if len(sys.argv) >= 2:
    serverURL = sys.argv[1]

# test cases, one array entry per test (may be multiple entries per class/file)
tests = [
    [ "test_CPCreateUser.py", "CPCreateUser", "test_logged_out_signup_path", "cp-createuser-bench.xml" ],
    [ "test_CPComments.py", "CPComments", "test_readonly_view_comment", "cp-comments-bench.xml" ],
    [ "test_CPShowProjects.py", "CPShowProjects", "test_readonly_view_projects", "cp-showprojects-bench.xml" ],
    [ "test_CPHearts.py", "CPHearts", "test_heart_projects", "cp-hearts-bench.xml" ]
    ]

# run tests
for test in tests:
    print '  Running %s test' % (test[1])

    if serverURL == None:
	subprocess.call( [ 'fl-run-bench %s %s.%s' % ( test[0], test[1], test[2]) ], shell=True )
    else:
	subprocess.call( [ 'fl-run-bench -u %s %s %s.%s' % ( serverURL, test[0], test[1], test[2]) ], shell=True )

# create reports
for test in tests:
    subprocess.call( [ 'fl-build-report --html', test[3] ], shell=True )

print "Testing complete."
