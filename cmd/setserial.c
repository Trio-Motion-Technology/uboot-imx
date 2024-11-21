#include <common.h>
#include <command.h>

static int do_setserial( cmd_tbl_t *cmdtp, int flag, int argc, char * const argv[] )
{
   unsigned int *addr;
   uint32_t val;
   char buffer[20];

   if ( argc <2 )  {
      printf ("Usage:\n%s\n", cmdtp->usage);
      return CMD_RET_USAGE;
   }

   addr = (unsigned int *)simple_strtol(argv[1], NULL, 16);

   if ( !addr ) {
      printf ("Usage:\n%s\n", cmdtp->usage);
      return CMD_RET_USAGE;
   }
   val = (*addr);
   sprintf(buffer, "%d", val);
   env_set("serial#", buffer);
   return CMD_RET_SUCCESS;
}

U_BOOT_CMD( set_serial_number, 2, 0, do_setserial,
   "set serial_number environment variable from ram",
   "set_serial_number <hexaddr>\n"
   "    - set environment variable 'serial_number' from 32 bit contents of 'hexaddr'\n"
);

