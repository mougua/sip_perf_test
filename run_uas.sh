sipp -sf b_reg.xml -inf b_user.csv -p 6068 -i 172.16.23.243 -m 5 172.16.23.243:5060
sleep 5
sipp -sf uas.xml -inf b_user.csv -p 6068 -i 172.16.23.243 -m 50 -aa 172.16.23.243:5060
