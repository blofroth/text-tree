BEGIN {
  tab_size = 2;
  last_depth = 0;
  depth = 0;
  max_d = 0;
}

/ +.+/ { 
  match($0, /( +)/); 
  depth = int(RLENGTH/tab_size);

  if ($1 ~ /[*#!?-]/) {
    marker = substr($0, RLENGTH+1,1)
    markers[depth] = marker
  }

  content = substr($0, RLENGTH+2);
  nodes[depth] = content;
  
  max_d = (depth > max_d) ? depth : max_d ;
  #print depth;
  if (depth < last_depth) {
    for (i=last_depth; i > depth; i--) {
      delete nodes[i]
      delete markers[i]
    }
  } else if (depth == last_depth) {
    num_children[depth-1] = num_children[depth-1] + 1
  } else {
    num_children[depth-1] = 1
  }
  # for (i=0; i <= max_d; i++) printf "%d: %d %s ", i, num_children[i], nodes[i];
  last_depth = depth;
  
}

{ 
  printf "%s: ", FILENAME
  for (i=0; i <= max_d; i++) {
    if (i in nodes) {printf "%s %s ", markers[i], nodes[i] };
  }
  print ""
}

# print all non-closed descendants
# '[*-?]'
# skippa alla 
# splitta i olika? parsa indent? descend?
# spara inga nodes när "false descend" 
# spara last depth

END {
  # print "max", max_d
}

# awk -F '[*#!X?-]' '// { print a; a=length($1); print length($1),substr($0,length($1),2), $2 }
# inte self contained i awk file?
# men kanske kan vara oneliner i bash?
# allt som matchar current indent? som regex?