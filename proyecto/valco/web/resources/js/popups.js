/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


                    function handleLoginRequest(xhr, status, args, popupname) {
                        if (args.validationFailed) {
                            PF(popupname).jq.effect("shake", {times: 5}, 100);
                        }
                        else {
                            PF(popupname).hide();
                            $('#loginLink').fadeOut();
                        }
                    }