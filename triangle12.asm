.data
	array: .space 12
	msg: .asciiz "Input 3 numbers :"
	print_1:		.asciiz		"EQUILATERAL\t"
	print_2:		.asciiz		"ISOSCELES\t"
	print_3:		.asciiz		"SCALENE\t"
	print_4:		.asciiz		"NOT A TRIANGLE\t"

.text
.globl main

main:
	li $v0,4
	la $a0,msg
	syscall
	la $s1,array

LOOPINPUT:
	li $v0,5
	syscall
	sw $v0,0($s1)
	addi $s1,$s1,4
	addi $t1,$t1,1
	bne $t1,3,LOOPINPUT


triangle:
        bgt     $a0, $a1, swap_ab
        bgt     $a1, $a2, swap_bc
        j       solve

swap_ab:
        move    $t0, $a1
        move    $a1, $a0
        move    $a0, $t0
        j       triangle

swap_bc:
        move    $t0, $a2
        move    $a2, $a1
        move    $a1, $t0
        j       triangle

solve:
        addu    $t0, $a0, $a1
        bge     $a2, $t0, invalid       # invalid if violate triangle inequality

        seq     $t0, $a0, $a1           # a == b
        seq     $t1, $a1, $a2           # b == c

        and     $t5, $t0, $t1
        or      $t6, $t0, $t1

        bne     $t5, $zero, equilateral
        bne     $t6, $zero, isoceles

        li      $v0, 0
        jr      $ra

equilateral:
        li      $v0, 2
        jr      $ra

isoceles:
        li      $v0, 1
        jr      $ra

invalid:
        li      $v0, 3
        jr      $ra