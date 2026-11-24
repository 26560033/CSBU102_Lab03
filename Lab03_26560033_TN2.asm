.data
nl:     .asciiz "\n"
prompt: .asciiz "Enter a score: "
.text
.globl main
main:
    addi $a0, $zero, 15         # a = 15
    addi $a1, $zero, 42         # b = 42
    jal  max2                   # $v0 = max2(15, 42)
    add  $a0, $v0, $zero        # copy the result first,
    li   $v0, 1                 # then print it
    syscall
    li   $v0, 4
    la   $a0, nl
    syscall
    addi $a0, $zero, -7         # a = -7
    addi $a1, $zero, -3         # b = -3
    jal  max2                   # $v0 = max2(-7, -3)
    add  $s1, $v0, $zero        # keep the result in $s1 (-3)
    li   $v0, 4
    la   $a0, prompt
    syscall
    li   $v0, 5                 # read an integer x into $v0
    syscall
    add  $a0, $v0, $zero        # argument 1: x
    addi $a1, $zero, 0          # argument 2: lo = 0
    addi $a2,