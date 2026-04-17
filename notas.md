# Fragmento A (vista desde switch B)

Primero se cae el switch D

*Mar  1 01:53:44.870: *** vp_linkchange: single: down: 1/3(1) 
*Mar  1 01:53:44.870: @@@ pm_vp 1/3(1): present -> not_present
*Mar  1 01:53:44.870: *** vp_statechange: single: remove: 1/3(1) 
*Mar  1 01:53:44.870: pm_vp_list_set_stp_state: !vpd || ps == vpd->stpState (vpd=OK)
*Mar  1 01:53:44.870: pm_vp_list_set_stp_state Fa0/2(1): ps(blocking) == vpd->stpState already!


# Fragmento B (vista desde switch B)

Primero el switch D falla

*Mar  1 00:48:43.958: @@@ pm_vp 1/3(1): forwarding -> notforwarding
*Mar  1 00:48:43.958: *** vp_fwdchange: single: notfwd: 1/3(1) 
*Mar  1 00:48:43.958: @@@ pm_vp 1/3(1): notforwarding -> present
*Mar  1 00:48:43.958: Found no corresponding dummy port for instance 1, port_id 128.3
*Mar  1 00:48:43.958: RSTP(1): updt roles, root port Fa0/3 going down

Luego el switch A manda una propuesta que el switch B acepta

*Mar  1 00:48:44.738: RSTP(1): transmitting an agreement on Gi0/1 as a response to a proposal

luego manda una propouesta a C en su puerto. Pero C no estaba respondiendo.

*Mar  1 00:48:44.738: RSTP(1): sending BPDU out Fa0/2
*Mar  1 00:48:44.738: RSTP(1): transmitting a proposal on Fa0/2
[....]

Como el handshake debia ser inmediado y no lo fue, el switch B callo devuelva a
depender en un timer en STP normal, hasta que C respondiese. Nunca lo hizo y los 20
segundos maximos del timer pasaron. No encontrando ninguna respuesta, el switch B mando
un TC trap

*Mar  1 00:49:14.744: RSTP(1): Fa0/2 fdwhile Expired
[...]
*Mar  1 00:49:14.744: STP[1]: Generating TC trap for port FastEthernet0/2
*Mar  1 00:49:14.752: RSTP(1): sending BPDU out Fa0/2
*Mar  1 00:49:14.752: RSTP(1): sending BPDU out Gi0/1
*Mar  1 00:49:14.987: RSTP(1): sending BPDU out Fa0/2
*Mar  1 00:49:14.987: RSTP(1): sending BPDU out Gi0/1

Reseteando la topologia para rehacer los handshakes (arriesgando loops). Una vez la red
se estabilizo, los pings de PC-B a PC-C volvieron.

Probablemente mientras B no podia hacer el handshake con C, los PC-A y PC-C se podrian
haber comunicado, pero como la prueba era de PC-B a PC-A, justo los switches que se
habian bloqueados entre ellos y el switch B aun no estaba seguro que la red era estable
entonces ningun ping paso y dio la apariencia de que rapid spanning tree era paradojica
mente mas lento, cuando en realidad fue un fallo de sincronizacion.

