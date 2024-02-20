BEGIN {
  tab_size = 2;
  last_depth = 0;
  depth = 0;
  mq = mq == "" ? "[*]" : mq;
  # print "marker filter:", mq
}

/^ +[*#!X?-]/ && $1 ~ mq {
  match($0, /^( +)/); 
  depth = int(RLENGTH/tab_size);
  if (depth > last_depth + 1 ) { next }
  print $0
  last_depth = depth;
}

# empty lines
/^$/
