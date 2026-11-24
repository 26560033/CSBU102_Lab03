.data
title:    .asciiz "SCORE REPORT\n"
endMsg:   .asciiz "END\n"
line:     .asciiz "----------\n"
starLine: .asciiz "**********\n"
.text
.globl main
main:
    jal  stars              # call (1): print the stars line
    li   $v0, 4
    la   $a0, title
    syscall                 # print SCORE REPORT
    jal  sep                # call (2): print the separator line
    li   $v0, 4
    la   $a0, endMsg
    syscall                 # print END
    jal  stars              # call (3): stars again, returns to a different place
    li   $v0, 10
    syscall                 # exit
# sep: prints a separator line
sep:
    li   $v0, 4
    la   $a0, line
    syscall
    jr   $ra                # return to the caller
# stars: prints a line of stars
stars:
    li   $v0, 4
    la   $a0, starLine
    syscall
    jr   $ra                # return to the caller