# 21CO_BUAA_2021_hjc-owo

## P1

### 课下测试 1

用 Logisim 实现一个简单的逻辑表达式：

![](http://latex.codecogs.com/svg.latex?Y=\overline{A}B+C+AD)

输入: A、B、C、D

输出: Y 

输入输出均为 1 bit 数据。

### 课下测试 2

实现小型ALU。

| ALUop | 对应的运算                               |
| ----- | ---------------------------------------- |
| 0000  | i1 << i2                                 |
| 0001  | i1 >>> i2                                |
| 0010  | i1 >> i2                                 |
| 0011  | i1 * i2 (无符号乘法，仅保留低 32 位结果) |
| 0100  | i1 / i2 (无符号除法，仅保留 32 位商)     |
| 0101  | i1 + i2                                  |
| 0110  | i1 - i2                                  |
| 0111  | i1 & i2                                  |
| 1000  | i1 \| i2                                 |
| 1001  | i1 ⊕ i2 |
| 1010 | i1 NOR i2 |
| 1011 | R = (X < Y) ? 1 : 0 (有符号比较) |
| 1100 | R = (X < Y) ? 1 : 0 (无符号比较) |

进行移位运算时，32 位二进制数 i2 表示移多少位，其高 27 位应该被舍弃，仅低 5 位有效。

输入：i1 (第一个运算数，32 bit)，i2 (第二个运算数，32 bit)， ALUOp (ALU 控制信号，4 bit)

输出：R (运算结果，32 bit)

### 课下测试 3

搭建一个 Mealy 型状态机解决 2^n mod 5 的数学问题。

输入: In (1 bit 串行输入)(每个时钟上升沿读入一个 1 bit 数)

输出: RESULT (运算结果，3 bit 二进制数)

### 课下测试 4

奇偶校验码是非常常用的一种校验码，它可以用来检查数据传输(或储存)过程中是否发生了突变错误。我们现在有一种最简单的奇偶校验码；发送方发送的数据是 9 位，其中，高 8 位是原始数据(也就是真正有意义需要传输的信息)，最后一位是机器生成的校验码(用于检验信息正确性)，例如 110111010，其中 11011101 是原始数据，最末尾的 0 是校验码。如果原始的 8 位数据中 1 的个数为偶数，那么机器生成的校验码就是 0；反之，若原始数据中 1 的个数为奇数，那么机器生成的校验码就应该是 1，拼装好的这个 9 位数就会被传送出去，接收方接收到这个 9 位数，需要校验数据在传输过程中是否发生偏差，就是根据这个校验码检验。

例如，如果接收到这样一个数 001100111，对应的 8 位原始数据是 00110011，1 的个数是偶数，然而尾随的校验码 1 却显示 8 位原始数据中 1 的个数应为奇数，这就说明数据在传输的过程中一定发生了错误。

本题要求你写一个接收机检验数据是否正确的电路。

我们的电路输入是接收到的 9 位数，对其进行检验，如果数据是正确的，就输出 8 位原始数据;如果是错误的，就输出 11111111。

输入：input (9 bits)

输出：output (8 bits)

### 课下测试 5

这道题要求你搭建一个具有排序功能的电路。

给定 4 个输入: i1，i2，i3，i4，均为 4 位二进制无符号数。

你需要对它们进行排序并输出排序后的结果，即保证四个输出的关系为 o1 >= o2 >= o3 >= o4。

输入：i1，i2，i3，i4 (均为 4 bit)

输出：o1，o2，o3，o4 (均为 4 bit)
