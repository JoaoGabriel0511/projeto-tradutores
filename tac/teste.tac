.table
int i_main_VARIABLE[] = {0, 0}
.code
jump main
main:
mov $2, 12
mov $3, 24
add $0, $2, $4
add $1, $3, $5
mov $2, &i_main_VARIABLE
mov $2[0], $0
mov $2[1], $1
mov $2, &i_main_VARIABLE
mov $2, $2[0]
print '<'
print $2
print ','
mov $2, &i_main_VARIABLE
mov $2, $2[1]
print $2
print '>'
println
