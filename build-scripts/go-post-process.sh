echo $1
gofmt -w -s $1
/home/ox26a/go/bin/goimports -w $1