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
static const char *ng0 = "C:/Users/Skrum_000/OneDrive/DTU/2. semester/Digitalteknik/Oscilloskop_projekt/DispMux.vhd";
extern char *IEEE_P_2592010699;



static void work_a_2941962287_3212880686_p_0(char *t0)
{
    char t16[16];
    char t17[16];
    char *t1;
    char *t2;
    unsigned char t3;
    unsigned char t4;
    char *t5;
    char *t6;
    char *t7;
    char *t8;
    unsigned char t9;
    unsigned char t10;
    int t11;
    unsigned char t12;
    char *t13;
    char *t14;
    int t15;
    unsigned int t18;
    char *t19;
    char *t20;
    char *t21;
    char *t22;

LAB0:    xsi_set_current_line(57, ng0);
    t1 = (t0 + 1032U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t4 = (t3 == (unsigned char)3);
    if (t4 != 0)
        goto LAB2;

LAB4:    t1 = (t0 + 1152U);
    t4 = xsi_signal_has_event(t1);
    if (t4 == 1)
        goto LAB7;

LAB8:    t3 = (unsigned char)0;

LAB9:    if (t3 != 0)
        goto LAB5;

LAB6:
LAB3:    xsi_set_current_line(71, ng0);
    t1 = (t0 + 2312U);
    t2 = *((char **)t1);
    t11 = *((int *)t2);
    if (t11 == 0)
        goto LAB16;

LAB22:    if (t11 == 1)
        goto LAB17;

LAB23:    if (t11 == 2)
        goto LAB18;

LAB24:    if (t11 == 3)
        goto LAB19;

LAB25:    if (t11 == 4)
        goto LAB20;

LAB26:
LAB21:    xsi_set_current_line(83, ng0);
    t1 = (t0 + 6706);
    t5 = (t0 + 3936);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t8 = (t7 + 56U);
    t13 = *((char **)t8);
    memcpy(t13, t1, 20U);
    xsi_driver_first_trans_fast_port(t5);

LAB15:    t1 = (t0 + 3792);
    *((int *)t1) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(58, ng0);
    t1 = (t0 + 3872);
    t5 = (t1 + 56U);
    t6 = *((char **)t5);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    *((int *)t8) = 0;
    xsi_driver_first_trans_fast(t1);
    goto LAB3;

LAB5:    xsi_set_current_line(60, ng0);
    t2 = (t0 + 2312U);
    t6 = *((char **)t2);
    t11 = *((int *)t6);
    t12 = (t11 > 4);
    if (t12 != 0)
        goto LAB10;

LAB12:    t1 = (t0 + 2152U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t4 = (t3 == (unsigned char)3);
    if (t4 != 0)
        goto LAB13;

LAB14:    xsi_set_current_line(65, ng0);
    t1 = (t0 + 2312U);
    t2 = *((char **)t1);
    t11 = *((int *)t2);
    t1 = (t0 + 3872);
    t5 = (t1 + 56U);
    t6 = *((char **)t5);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    *((int *)t8) = t11;
    xsi_driver_first_trans_fast(t1);

LAB11:    goto LAB3;

LAB7:    t2 = (t0 + 1192U);
    t5 = *((char **)t2);
    t9 = *((unsigned char *)t5);
    t10 = (t9 == (unsigned char)3);
    t3 = t10;
    goto LAB9;

LAB10:    xsi_set_current_line(61, ng0);
    t2 = (t0 + 3872);
    t7 = (t2 + 56U);
    t8 = *((char **)t7);
    t13 = (t8 + 56U);
    t14 = *((char **)t13);
    *((int *)t14) = 0;
    xsi_driver_first_trans_fast(t2);
    goto LAB11;

LAB13:    xsi_set_current_line(63, ng0);
    t1 = (t0 + 2312U);
    t5 = *((char **)t1);
    t11 = *((int *)t5);
    t15 = (t11 + 1);
    t1 = (t0 + 3872);
    t6 = (t1 + 56U);
    t7 = *((char **)t6);
    t8 = (t7 + 56U);
    t13 = *((char **)t8);
    *((int *)t13) = t15;
    xsi_driver_first_trans_fast(t1);
    goto LAB11;

LAB16:    xsi_set_current_line(73, ng0);
    t1 = (t0 + 6644);
    t6 = (t0 + 3936);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t13 = (t8 + 56U);
    t14 = *((char **)t13);
    memcpy(t14, t1, 20U);
    xsi_driver_first_trans_fast_port(t6);
    goto LAB15;

LAB17:    xsi_set_current_line(75, ng0);
    t1 = (t0 + 6664);
    t5 = (t0 + 1352U);
    t6 = *((char **)t5);
    t7 = ((IEEE_P_2592010699) + 4024);
    t8 = (t17 + 0U);
    t13 = (t8 + 0U);
    *((int *)t13) = 0;
    t13 = (t8 + 4U);
    *((int *)t13) = 17;
    t13 = (t8 + 8U);
    *((int *)t13) = 1;
    t11 = (17 - 0);
    t18 = (t11 * 1);
    t18 = (t18 + 1);
    t13 = (t8 + 12U);
    *((unsigned int *)t13) = t18;
    t13 = (t0 + 6492U);
    t5 = xsi_base_array_concat(t5, t16, t7, (char)97, t1, t17, (char)97, t6, t13, (char)101);
    t18 = (18U + 2U);
    t3 = (20U != t18);
    if (t3 == 1)
        goto LAB28;

LAB29:    t14 = (t0 + 3936);
    t19 = (t14 + 56U);
    t20 = *((char **)t19);
    t21 = (t20 + 56U);
    t22 = *((char **)t21);
    memcpy(t22, t5, 20U);
    xsi_driver_first_trans_fast_port(t14);
    goto LAB15;

LAB18:    xsi_set_current_line(77, ng0);
    t1 = (t0 + 6682);
    t5 = (t0 + 1512U);
    t6 = *((char **)t5);
    t7 = ((IEEE_P_2592010699) + 4024);
    t8 = (t17 + 0U);
    t13 = (t8 + 0U);
    *((int *)t13) = 0;
    t13 = (t8 + 4U);
    *((int *)t13) = 11;
    t13 = (t8 + 8U);
    *((int *)t13) = 1;
    t11 = (11 - 0);
    t18 = (t11 * 1);
    t18 = (t18 + 1);
    t13 = (t8 + 12U);
    *((unsigned int *)t13) = t18;
    t13 = (t0 + 6508U);
    t5 = xsi_base_array_concat(t5, t16, t7, (char)97, t1, t17, (char)97, t6, t13, (char)101);
    t18 = (12U + 8U);
    t3 = (20U != t18);
    if (t3 == 1)
        goto LAB30;

LAB31:    t14 = (t0 + 3936);
    t19 = (t14 + 56U);
    t20 = *((char **)t19);
    t21 = (t20 + 56U);
    t22 = *((char **)t21);
    memcpy(t22, t5, 20U);
    xsi_driver_first_trans_fast_port(t14);
    goto LAB15;

LAB19:    xsi_set_current_line(79, ng0);
    t1 = (t0 + 6694);
    t5 = (t0 + 1672U);
    t6 = *((char **)t5);
    t7 = ((IEEE_P_2592010699) + 4024);
    t8 = (t17 + 0U);
    t13 = (t8 + 0U);
    *((int *)t13) = 0;
    t13 = (t8 + 4U);
    *((int *)t13) = 11;
    t13 = (t8 + 8U);
    *((int *)t13) = 1;
    t11 = (11 - 0);
    t18 = (t11 * 1);
    t18 = (t18 + 1);
    t13 = (t8 + 12U);
    *((unsigned int *)t13) = t18;
    t13 = (t0 + 6524U);
    t5 = xsi_base_array_concat(t5, t16, t7, (char)97, t1, t17, (char)97, t6, t13, (char)101);
    t18 = (12U + 8U);
    t3 = (20U != t18);
    if (t3 == 1)
        goto LAB32;

LAB33:    t14 = (t0 + 3936);
    t19 = (t14 + 56U);
    t20 = *((char **)t19);
    t21 = (t20 + 56U);
    t22 = *((char **)t21);
    memcpy(t22, t5, 20U);
    xsi_driver_first_trans_fast_port(t14);
    goto LAB15;

LAB20:    xsi_set_current_line(81, ng0);
    t1 = (t0 + 1832U);
    t2 = *((char **)t1);
    t1 = (t0 + 3936);
    t5 = (t1 + 56U);
    t6 = *((char **)t5);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    memcpy(t8, t2, 20U);
    xsi_driver_first_trans_fast_port(t1);
    goto LAB15;

LAB27:;
LAB28:    xsi_size_not_matching(20U, t18, 0);
    goto LAB29;

LAB30:    xsi_size_not_matching(20U, t18, 0);
    goto LAB31;

LAB32:    xsi_size_not_matching(20U, t18, 0);
    goto LAB33;

}


extern void work_a_2941962287_3212880686_init()
{
	static char *pe[] = {(void *)work_a_2941962287_3212880686_p_0};
	xsi_register_didat("work_a_2941962287_3212880686", "isim/DispMuxTB_isim_beh.exe.sim/work/a_2941962287_3212880686.didat");
	xsi_register_executes(pe);
}
