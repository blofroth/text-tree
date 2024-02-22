BEGIN {
  tab_size = 2;
  last_depth = 0;
  depth = 0;
  mq = mq == "" ? "[*]" : mq;
  last_skip_depth = -2;
  # print "marker filter:", mq
}

/^ +[*#!X?-]/ && $1 ~ mq {
  match($0, /^( +)/); 
  depth = int(RLENGTH/tab_size);
  if (depth > last_depth + 1 ) { next }
  if (last_skip_depth == depth - 1 ) { next }
  print $0
  last_depth = depth;
  last_skip_depth = -2;
}

/^ +[*#!X?-]/ && $1 !~ mq {
  match($0, /^( +)/); 
  last_skip_depth = int(RLENGTH/tab_size);
}

# empty lines
/^$/
