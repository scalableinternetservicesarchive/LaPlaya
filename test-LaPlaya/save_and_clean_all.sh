DIRNAME=laplaya-testrun-$(date +%s)
FILENAME=$DIRNAME.tar.gz

mkdir $DIRNAME
mv *.xml* $DIRNAME
mv test_*-201412* $DIRNAME
tar -czf $FILENAME $DIRNAME/*

rm -f *.log
rm -f *.xml*
rm -f *.pyc
rm -r $DIRNAME