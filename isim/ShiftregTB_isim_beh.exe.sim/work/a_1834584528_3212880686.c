/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                       */
/*  \   \        Copyright (c) 2003-2009 Xilinx, Inc.                */
/*  /   /          All Right Reserved.                                 */
/* /---/   /\                                                         */
/* \   \  /  \                                                      */
/*  \___\/\___\                                                    */
/***********************************************************************/

/* This file is designed for use with ISim build 0x7708f090 */

#define XSI_HIDE_SYMBOL_SPEC true
#include "xsi.h"
#include <memory.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
static const char *ng0 = "C:/Users/Skrum_000/Desktop/shiftreg.vhd";
extern char *IEEE_P_2592010699;



static void work_a_1834584528_3212880686_p_0(char *t0)
{
    char t19[16];
    char *t1;
    char *t2;
    unsigned char t3;
    unsigned char t4;
    char *t5;
    char *t6;
    char *t7;
    char *t8;
    char *t9;
    char *t10;
    unsigned char t11;
    unsigned char t12;
    int t13;
    unsigned int t14;
    unsigned int t15;
    unsigned int t16;
    unsigned char t17;
    unsigned char t18;
    unsigned int t20;
    unsigned char t21;
    char *t22;
    char *t23;
    char *t24;
    char *t25;

LAB0:    xsi_set_current_line(50, ng0);
    t1 = (t0 + 1032U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t4 = (t3 == (unsigned char)3);
    if (t4 != 0)
        goto LAB2;

LAB4:    t1 = (t0 + 1312U);
    t4 = xsi_signal_has_event(t1);
    if (t4 == 1)
        goto LAB7;

LAB8:    t3 = (unsigned char)0;

LAB9:    if (t3 != 0)
        goto LAB5;

LAB6:
LAB3:    t1 = (t0 + 4128);
    *((int *)t1) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(51, ng0);
    t1 = (t0 + 6303);
    t6 = (t0 + 4240);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    memcpy(t10, t1, 2U);
    xsi_driver_first_trans_fast(t6);
    goto LAB3;

LAB5:    xsi_set_current_line(53, ng0);
    t2 = (t0 + 1992U);
    t6 = *((char **)t2);
    t13 = (0 - 1);
    t14 = (t13 * -1);
    t15 = (1U * t14);
    t16 = (0 + t15);
    t2 = (t6 + t16);
    t17 = *((unsigned char *)t2);
    t7 = (t0 + 1192U);
    t8 = *((char **)t7);
    t18 = *((unsigned char *)t8);
    t9 = ((IEEE_P_2592010699) + 4024);
    t7 = xsi_base_array_concat(t7, t19, t9, (char)99, t17, (char)99, t18, (char)101);
    t20 = (1U + 1U);
    t21 = (2U != t20);
    if (t21 == 1)
        goto LAB10;

LAB11:    t10 = (t0 + 4240);
    t22 = (t10 + 56U);
    t23 = *((char **)t22);
    t24 = (t23 + 56U);
    t25 = *((char **)t24);
    memcpy(t25, t7, 2U);
    xsi_driver_first_trans_fast(t10);
    goto LAB3;

LAB7:    t2 = (t0 + 1352U);
    t5 = *((char **)t2);
    t11 = *((unsigned char *)t5);
    t12 = (t11 == (unsigned char)3);
    t3 = t12;
    goto LAB9;

LAB10:    xsi_size_not_matching(2U, t20, 0);
    goto LAB11;

}

static void work_a_1834584528_3212880686_p_1(char *t0)
{
    char t26[16];
    char t28[16];
    char *t1;
    char *t2;
    unsigned char t3;
    unsigned char t4;
    char *t5;
    char *t6;
    char *t7;
    char *t8;
    char *t9;
    char *t10;
    unsigned char t11;
    unsigned char t12;
    unsigned char t13;
    unsigned char t14;
    unsigned int t15;
    char *t16;
    unsigned char t17;
    unsigned char t18;
    char *t19;
    unsigned int t20;
    unsigned int t21;
    unsigned int t22;
    char *t23;
    char *t24;
    unsigned char t25;
    char *t27;
    char *t29;
    char *t30;
    int t31;
    unsigned int t32;
    unsigned char t33;
    char *t34;
    char *t35;
    char *t36;
    char *t37;

LAB0:    xsi_set_current_line(59, ng0);
    t1 = (t0 + 1032U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t4 = (t3 == (unsigned char)3);
    if (t4 != 0)
        goto LAB2;

LAB4:    t1 = (t0 + 1312U);
    t4 = xsi_signal_has_event(t1);
    if (t4 == 1)
        goto LAB7;

LAB8:    t3 = (unsigned char)0;

LAB9:    if (t3 != 0)
        goto LAB5;

LAB6:
LAB3:    t1 = (t0 + 4144);
    *((int *)t1) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(60, ng0);
    t1 = (t0 + 6305);
    t6 = (t0 + 4304);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    memcpy(t10, t1, 8U);
    xsi_driver_first_trans_fast(t6);
    goto LAB3;

LAB5:    xsi_set_current_line(62, ng0);
    t2 = (t0 + 1992U);
    t6 = *((char **)t2);
    t2 = (t0 + 6313);
    t14 = 1;
    if (2U == 2U)
        goto LAB16;

LAB17:    t14 = 0;

LAB18:    if (t14 == 1)
        goto LAB13;

LAB14:    t13 = (unsigned char)0;

LAB15:    if (t13 != 0)
        goto LAB10;

LAB12:
LAB11:    goto LAB3;

LAB7:    t2 = (t0 + 1352U);
    t5 = *((char **)t2);
    t11 = *((unsigned char *)t5);
    t12 = (t11 == (unsigned char)3);
    t3 = t12;
    goto LAB9;

LAB10:    xsi_set_current_line(63, ng0);
    t10 = (t0 + 2152U);
    t19 = *((char **)t10);
    t20 = (7 - 6);
    t21 = (t20 * 1U);
    t22 = (0 + t21);
    t10 = (t19 + t22);
    t23 = (t0 + 1512U);
    t24 = *((char **)t23);
    t25 = *((unsigned char *)t24);
    t27 = ((IEEE_P_2592010699) + 4024);
    t29 = (t28 + 0U);
    t30 = (t29 + 0U);
    *((int *)t30) = 6;
    t30 = (t29 + 4U);
    *((int *)t30) = 0;
    t30 = (t29 + 8U);
    *((int *)t30) = -1;
    t31 = (0 - 6);
    t32 = (t31 * -1);
    t32 = (t32 + 1);
    t30 = (t29 + 12U);
    *((unsigned int *)t30) = t32;
    t23 = xsi_base_array_concat(t23, t26, t27, (char)97, t10, t28, (char)99, t25, (char)101);
    t32 = (7U + 1U);
    t33 = (8U != t32);
    if (t33 == 1)
        goto LAB22;

LAB23:    t30 = (t0 + 4304);
    t34 = (t30 + 56U);
    t35 = *((char **)t34);
    t36 = (t35 + 56U);
    t37 = *((char **)t36);
    memcpy(t37, t23, 8U);
    xsi_driver_first_trans_fast(t30);
    goto LAB11;

LAB13:    t10 = (t0 + 1672U);
    t16 = *((char **)t10);
    t17 = *((unsigned char *)t16);
    t18 = (t17 == (unsigned char)2);
    t13 = t18;
    goto LAB15;

LAB16:    t15 = 0;

LAB19:    if (t15 < 2U)
        goto LAB20;
    else
        goto LAB18;

LAB20:    t8 = (t6 + t15);
    t9 = (t2 + t15);
    if (*((unsigned char *)t8) != *((unsigned char *)t9))
        goto LAB17;

LAB21:    t15 = (t15 + 1);
    goto LAB19;

LAB22:    xsi_size_not_matching(8U, t32, 0);
    goto LAB23;

}

static void work_a_1834584528_3212880686_p_2(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;

LAB0:    xsi_set_current_line(68, ng0);

LAB3:    t1 = (t0 + 2152U);
    t2 = *((char **)t1);
    t1 = (t0 + 4368);
    t3 = (t1 + 56U);
    t4 = *((char **)t3);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    memcpy(t6, t2, 8U);
    xsi_driver_first_trans_fast_port(t1);

LAB2:    t7 = (t0 + 4160);
    *((int *)t7) = 1;

LAB1:    return;
LAB4:    goto LAB2;

}


extern void work_a_1834584528_3212880686_init()
{
	static char *pe[] = {(void *)work_a_1834584528_3212880686_p_0,(void *)work_a_1834584528_3212880686_p_1,(void *)work_a_1834584528_3212880686_p_2};
	xsi_register_didat("work_a_1834584528_3212880686", "isim/ShiftregTB_isim_beh.exe.sim/work/a_1834584528_3212880686.didat");
	xsi_register_executes(pe);
}
