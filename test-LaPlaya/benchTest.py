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
    [ "test_CPComments.py", "CPComments", "test_create_comment", "cp-comments-bench.xml" ],
    [ "test_CPShowProjects.py", "CPShowProjects", "test_readonly_view_projects", "cp-showprojects-bench.xml" ],
    [ "test_CPHearts.py", "CPHearts", "test_heart_projects", "cp-hearts-bench.xml" ]
    ]

# run tests
for test in tests:
    cmd = ""

    if serverURL == None:
        cmd = 'fl-run-bench %s %s.%s' % ( test[0], test[1], test[2])
    else:
        cmd = 'fl-run-bench -u http://%s/ %s %s.%s' % ( serverURL, test[0], test[1], test[2])

    print '*** Testing: %s.%s ***' % (test[1], test[2])
    subprocess.call( [ cmd ], shell=True )
    subprocess.call( [ 'fl-build-report --html %s' % ( test[3] ) ], shell=True )

print "Testing complete."
