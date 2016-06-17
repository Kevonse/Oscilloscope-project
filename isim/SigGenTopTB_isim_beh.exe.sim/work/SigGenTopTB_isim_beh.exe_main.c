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

#include "xsi.h"

struct XSI_INFO xsi_info;

char *IEEE_P_2592010699;
char *IEEE_P_1242562249;
char *STD_TEXTIO;
char *IEEE_P_3620187407;
char *IEEE_P_3499444699;
char *STD_STANDARD;
char *IEEE_P_3564397177;


int main(int argc, char **argv)
{
    xsi_init_design(argc, argv);
    xsi_register_info(&xsi_info);

    xsi_register_min_prec_unit(-12);
    ieee_p_2592010699_init();
    ieee_p_3499444699_init();
    ieee_p_3620187407_init();
    ieee_p_1242562249_init();
    work_a_1834584528_3212880686_init();
    work_a_2320649066_3212880686_init();
    work_a_3958530957_3366848769_init();
    work_a_1421884221_3212880686_init();
    work_a_2941962287_3212880686_init();
    work_a_0840209509_2117282823_init();
    work_a_1877074815_3212880686_init();
    std_textio_init();
    ieee_p_3564397177_init();
    xilinxcorelib_a_2543390064_2959432447_init();
    xilinxcorelib_a_4286692035_1709443946_init();
    xilinxcorelib_a_1178171251_0543512595_init();
    xilinxcorelib_a_2005576406_3212880686_init();
    work_a_2186922994_1482076668_init();
    work_a_0720361590_3212880686_init();
    work_a_3455286857_3212880686_init();
    work_a_3007750439_2372691052_init();


    xsi_register_tops("work_a_3007750439_2372691052");

    IEEE_P_2592010699 = xsi_get_engine_memory("ieee_p_2592010699");
    xsi_register_ieee_std_logic_1164(IEEE_P_2592010699);
    IEEE_P_1242562249 = xsi_get_engine_memory("ieee_p_1242562249");
    STD_TEXTIO = xsi_get_engine_memory("std_textio");
    IEEE_P_3620187407 = xsi_get_engine_memory("ieee_p_3620187407");
    IEEE_P_3499444699 = xsi_get_engine_memory("ieee_p_3499444699");
    STD_STANDARD = xsi_get_engine_memory("std_standard");
    IEEE_P_3564397177 = xsi_get_engine_memory("ieee_p_3564397177");

    return xsi_run_simulation(argc, argv);

}
