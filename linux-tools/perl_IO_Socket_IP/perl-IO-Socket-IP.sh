#!/bin/bash
###########################################################################################
## Copyright 2003, 2016 IBM Corp                                                          ##
##                                                                                        ##
## Redistribution and use in source and binary forms, with or without modification,       ##
## are permitted provided that the following conditions are met:                          ##
##      1.Redistributions of source code must retain the above copyright notice,          ##
##        this list of conditions and the following disclaimer.                           ##
##      2.Redistributions in binary form must reproduce the above copyright notice, this  ##
##        list of conditions and the following disclaimer in the documentation and/or     ##
##        other materials provided with the distribution.                                 ##
##                                                                                        ##
## THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS ``AS IS AND ANY EXPRESS       ##
## OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF        ##
## MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL ##
## THE AUTHOR OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,    ##
## EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF     ##
## SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) ##
## HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,  ##
## OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS  ##
## SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.                           ##
############################################################################################
### File :        perl-IO-Socket-IP.sh                                           ##
##
### Description: This testcase tests perl-IO-Socket-IP package                   ##
##
### Author: Hariharan T.S. <harihare@in.ibm.com>                                  ##
###########################################################################################

######cd $(dirname $0)
#LTPBIN=${LTPBIN%/shared}/perl_IO_Socket_IP
source $LTPBIN/tc_utils.source
TESTS_DIR="${LTPBIN%/shared}/perl_IO_Socket_IP"
required="perl rpm"
function tc_local_setup()
{
    # check installation and environment
    tc_exec_or_break $required

    # install check
    rpm -q "perl-IO-Socket-IP" >$stdout 2>$stderr
    tc_break_if_bad $? "perl-IO-Socket-IP not installed"
   

}

################################################################################
# testcase functions                                                           #
################################################################################
#
# Function:             runtests
#
# Description:          - test perl-IO-Socket-IP
#
# Parameters:           - none
#
# Return                - zero on success
#                       - return value from commands on failure
################################################################################

function runtests()
{
    pushd $TESTS_DIR &>/dev/null
    TESTS=`ls t/*.t`
    TST_TOTAL=`echo $TESTS | wc -w`
    for test in $TESTS; do
        tc_register "Test $test"
        perl $test >$stdout 2>$stderr
        tc_pass_or_fail $? "Test $test failed"
    done
    popd &>/dev/null
}


##############################################
#MAIN                                        #
##############################################
TST_TOTAL=1
tc_setup
runtests


