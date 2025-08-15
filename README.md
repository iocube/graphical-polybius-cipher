# graphical-polybius-cipher

Initial bash script functionality:
```bash
silver@greybox:~/Projects/graphical-polybius-cipher$ ./square.sh encrypt Message1
32 15 43 43 11 22 15 1

silver@greybox:~/Projects/graphical-polybius-cipher$ ./square.sh decrypt "32 15 43 43 11 22 15 1"
MESSAGE1

silver@greybox:~/Projects/graphical-polybius-cipher$ echo "2nd Message" | ./square.sh enc
2 33 14 32 15 43 43 11 22 15

silver@greybox:~/Projects/graphical-polybius-cipher$ echo "2 33 14 32 15 43 43 11 22 15" | ./square.sh dec
2NDMESSAGE
```

TODO:
- ~~create shell script as a prototype~~
- transfer to golang and combine with charm tui lib
