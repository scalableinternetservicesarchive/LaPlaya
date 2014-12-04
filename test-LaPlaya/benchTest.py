#!/usr/bin/env python
import subprocess

# grab URL from stdin


# test cases, one array entry per test (may be multiple entries per class/file)
tests = [
    { "test_CPCreateUser.py", "CPCreateUser", "test_logged_out_signup_path" },
    { "test_CPComments.py", "CPComments", "test_readonly_view_comment" },
    { "test_CPShowProjects.py", "CPShowProjects", "test_readonly_view_projects" },
    { "test_CPHearts.py", "CPHearts", "test_heart_projects" }
    ]

# run tests
for test in tests:
    # TODO: add argument to substitute stdin URL for config URL
    subprocess.call(['fl-run-bench', test[0], '%s.%s' % (test[1], test[2])])

# create reports
