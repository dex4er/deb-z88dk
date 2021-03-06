/* $Id: tftp.h,v 1.3 2001/10/16 18:30:32 dom Exp $ */

/*
 * Copyright (c) 1983 Regents of the University of California.
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 * 3. All advertising materials mentioning features or use of this software
 *    must display the following acknowledgement:
 *      This product includes software developed by the University of
 *      California, Berkeley and its contributors.
 * 4. Neither the name of the University nor the names of its contributors
 *    may be used to endorse or promote products derived from this software
 *    without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE REGENTS AND CONTRIBUTORS ``AS IS'' AND
 * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 * ARE DISCLAIMED.  IN NO EVENT SHALL THE REGENTS OR CONTRIBUTORS BE LIABLE
 * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
 * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
 * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
 * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
 * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
 * SUCH DAMAGE.
 *
 *      @(#)tftp.h      5.4 (Berkeley) 4/3/91
 */

#ifndef __NET_TFTP_H__
#define __NET_TFTP_H__

#include <sys/types.h>

/*
 * Trivial File Transfer Protocol (IEN-133)
 */
#define SEGSIZE         512             /* data segment size */

/*
 * Packet types.
 */
#define RRQ     01                      /* read request */
#define WRQ     02                      /* write request */
#define DATA    03                      /* data packet */
#define ACK     04                      /* acknowledgement */
#define ERROR   05                      /* error code */

struct  tftphdr {
        u16_t   th_opcode;              /* packet type */
        union tftp_0xx {
                u16_t   tu_block;       /* block # */
                u16_t   tu_code;        /* error code */
                u8_t    tu_stuff[1];    /* request packet stuff */
        } th_u;
        u8_t    th_data[1];             /* data or error string */
};

#define th_block        th_u.tu_block
#define th_code         th_u.tu_code
#define th_stuff        th_u.tu_stuff
#define th_msg          th_data

/*
 * Error codes.
 */
#define EUNDEF          0               /* not defined */
#define ENOTFOUND       1               /* file not found */
#define EACCESS         2               /* access violation */
#define ENOSPACE        3               /* disk full or allocation exceeded */
#define EBADOP          4               /* illegal TFTP operation */
#define EBADID          5               /* unknown transfer ID */
#define EEXISTS         6               /* file already exists */
#define ENOUSER         7               /* no such user */

#define TFTPTIMEOUT	5		/* djm timeout in secs */

#endif /* !_TFTP_H_ */
