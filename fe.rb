require 'shellwords'
File.open(%q[D:\01.xml], "a") { |f|  f.write(%q[01" noone="0" phone="+79184206025" mail="" sex="1" age="68" status="-1" status_name="не выбрано" variant_code="1" expelled="false" start_time="13:22:00" end_time="13:47:00" delta="25" result_mask="--++++-+++++-+++++-+" mark="15" completed="75%"><answers><answer number="1" type="0" code="1" value="4" mark="0"/><answer number="2" type="0" code="2" value="2" mark="0"/><answer number="3" type="0" code="3" value="2" mark="1"/><answer number="4" type="0" code="4" value="4" mark="1"/><answer number="5" type="0" code="5" value="2" mark="1"/><answer number="6" type="0" code="6" value="2" mark="1"/><answer number="7" type="0" code="7" value="1" mark="0"/><answer number="8" type="0" code="8" value="4" mark="1"/><answer number="9" type="0" code="9" value="8" mark="1"/><answer number="10" type="0" code="10" value="8" mark="1"/><answer number="11" type="0" code="11" value="2" mark="1"/><answer number="12" type="0" code="12" value="1" mark="1"/><answer number="13" type="0" code="13" value="1" mark="0"/><answer number="14" type="1" code="1" value="дорогажизни" mark="1"/><answer number="15" type="1" code="2" value="т-34" mark="1"/><answer number="16" type="1" code="3" value="парадпобеды" mark="1"/><answer number="17" type="1" code="4" value="волгоград" mark="1"/><answer number="18" type="1" code="5" value="231" mark="1"/><answer number="19" type="1" code="6" value="2341" mark="0"/><answer number="20" type="1" code="7" value="312" mark="1"/></answers></participant><participant id="375EDCA2-C9F6-40CC-AA44-BD8B4DC1B8B3" code="2800000000219" station_code="0001" noone="0" phone="8962763993" mail="Bysik4665699@mail.ru" sex="1" age="27" status="-1" status_name="не выбрано" variant_code="1" expelled="false" start_time="13:22:00" end_time="13:50:00" delta="28" result_mask="-++++++-+---+++++--+" mark="13" completed="65%"><answers><answer number="1" type="0" code="1" value="4" mark="0"/><answer number="2" type="0" code="2" value="1" mark="1"/><answer number="3" type="0" code="3" value="2" mark="1"/><answer number="4" type="0" code="4" value="4" mark="1"/><answer number="5" type="0" code="5" value="2" mark="1"/><answer number="6" type="0" code="6" value="2" mark="1"/><answer number="7" type="0" code="7" value="2" mark="1"/><answer number="8" type="0" code="8" value="2" mark="0"/><answer number="9" type="0" code="9" value="8" mark="1"/><answer number="10" type="0" code="10" value="4" mark="0"/><answer number="11" type="0" code="11" value="8" mark="0"/><answer number="12" type="0" code="12" value="8" mark="0"/><answer number="13" type="0" code="13" value="8" mark="1"/><answer number="14" type="1" code="1" value="дорогажизни" mark="1"/><answer number="15" type="1" code="2" value="т-34" mark="1"/><answer number="16" type="1" code="3" value="парадпобеды" mark="1"/><answer number="17" type="1" code="4" value="волгоград" mark="1"/><answer number="18" type="1" code="5" value="3421" mark="0"/><answer number="19" type="1" code="6" value="3421" mark="0"/><answer number="20" type="1" code="7" value="312" mark="1"/></answers></participant><participant id="53B0D881-169D-4686-84B8-A646CB34961E" code="2800000000226" station_code="0001" noone="0" phone="9880803010" mail="Daurov.aslan88@mail.ru" sex="0" age="50" status="6" status_name="Работающий" variant_code="1" expelled="false" start_time="13:22:00" end_time="13:47:00" delta="25" result_mask="-+----+-++-+--+-----" mark="6" completed="30%"><answers><answer number="1" type="0" code="1" value="4" mark="0"/><answer number="2" type="0" code="2" value="1" mark="1"/><answer number="3" type="0" code="3" value="1" mark="0"/><answer number="4" type="0" code="4" value="8" mark="0"/><answer number="5" type="0" code="5" value="1" mark="0"/><answer number="6" type="0" code="6" value="1" mark="0"/><answer number="7" type="0" code="7" value="2" mark="1"/><answer number="8" type="0" code="8" value="8" mark="0"/><answer number="9" type="0" code="9" value="8" mark="1"/><answer number="10" type="0" code="10" value="8" mark="1"/><answer number="11" type="0" code="11" value="4" mark="0"/><answer number="12" type="0" code="12" value="1" mark="1"/><answer number="13" type="0" code="13" value="1" mark="0"/><answer number="14" type="1" code="1" value="" mark="0"/><answer number="15" type="1" code="2" value="т34" mark="1"/><answer number="16" type="1" code="3" value="парад" mark="0"/><answer number="17" type="1" code="4" value="ростов" mark="0"/><answer number="18" type="1" code="5" value="213" mark="0"/><answer number="19" type="1" code="6" value="1324" mark="0"/><answer number="20" type="1" code="7" value="213" mark="0"/></answers></participant><participant id="69CF9277-55B7-4DCE-9BCC-47F9900B3CC1" code="2800000000233" station_code="0001" noone="0" phone="9184254181" mail="" sex="0" age="21" status="2" status_name="Студент" variant_code="1" expelled="false" start_time="13:22:00" end_time="13:44:00" delta="22" result_mask="+-----+-++-+++++---+" mark="10" completed="50%"><answers><answer number="1" type="0" code="1" value="2" mark="1"/><answer number="2" type="0" code="2" value="2" mark="0"/><answer number="3" type="0" code="3" value="4" mark="0"/><answer number="4" type="0" code="4" value="8" mark="0"/><answer number="5" type="0" code="5" value="1" mark="0"/><answer number="6" type="0" code="6" value="8" mark="0"/><answer number="7" type="0" code="7" value="2" mark="1"/><answer number="8" type="0" code="8" value="1" mark="0"/><answer number="9" type="0" code="9" value="8" mark="1"/><answer number="10" type="0" code="10" value="8" mark="1"/><answer number="11" type="0" code="11" value="4" mark="0"/><answer number="12" type="0" code="12" value="1" mark="1"/><answer number="13" type="0" code="13" value="8" mark="1"/><answer number="14" type="1" code="1" value="дорогажизни" mark="1"/><answer number="15" type="1" code="2" value="т34" mark="1"/><answer number="16" type="1" code="3" value="парадпобеды" mark="1"/><answer number="17" type="1" code="4" value="москва" mark="0"/><answer number="18" type="1" code="5" v]) }