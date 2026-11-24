.data
classA: .word 72, 55, 90, 48, 63, 85, 39, 77, 60, 94
classB: .word 45, 81, 66, 50, 92, 38, 70, 59
msgAmin: .asciiz "Class A min: "
msgAmax: .asciiz "Class A max: "
msgBmin: .asciiz "Class B min: "
msgBmax: .asciiz "Class B max: "
nl:      .asciiz "\n"
.text
.globl main
main:
    la   $a0, classA
    addi $a1, $zero, 10
    jal  min_max                # $v0 = min, $v1 = max of class A
    add  $s1, $v0, $zero        # copy both results at once
    add  $s2, $v1, $zero        # (show changes $v0)
    la   $a0, msgAmin
    add  $a1, $s1, $zero
    jal  show
    la   $a0, msgAmax
    add  $a1, $s2, $zero
    jal  show
    la   $a0, classB
    addi $a1, $zero, 8
    jal  min_max                # $v0 = min, $v1 = max of class B
    add  $s1, $v0, $zero
    add  $s2, $v1, $zero
    la   $a0, msgBmin
    add  $a1, $s1, $zero
    jal  show
    la   $a0, msgBmax
    add  $a1, $s2, $zero
    jal  show
    li   $v0, 10
    syscall
# min_max(addr = $a0, n = $a1): min of n words in $v0, max in $v1
min_max:
    lw   $v0, 0($a0)            # min = element 0
    add  $v1, $v0, $zero        # max = element 0
    addi $t0, $zero, 1          # i = 1
mm_loop:
    slt  $t1, $t0, $a1          # $t1 = 1 if i < n
    beq  $t1, $zero, mm_end
    sll  $t2, $t0, 2            # $t2 = 4 * i
    add  $t2, $t2, $a0          # $t2 = address of element i
    lw   $t3, 0($t2)            # $t3 = element i
    slt  $t4, $t3, $v0          # element < min ?
    beq  $t4, $zero, mm_max
    add  $v0, $t3, $zero        # new min
mm_max:
    slt  $t4, $v1, $t3          # max < element ?
    beq  $t4, $zero, mm_next
    add  $v1, $t3, $zero        # new max
mm_next:
    addi $t0, $t0, 1            # i = i + 1
    j    mm_loop
mm_end:
    jr   $ra
# show(msg = $a0, value = $a1): prints msg, value and a new line
show:
    li   $v0, 4
    syscall
    li   $v0, 1
    add  $a0, $a1, $zero
    syscall
    li   $v0, 4
    la   $a0, nl
    syscall
    jr   $ra