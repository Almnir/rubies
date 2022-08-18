require 'nokogiri'

objectslistxml = 
"<list>" +
"<object name='Лицензируемые ОП' code='EIIS.LICENSED_PROGRAMS'>\n" +
"<primary name='Код записи' code='ID' type='0'/>\n" +
"<reference code='REGION_LOCATION' object='EIIS.REGIONS'/>\n" +
"<reference code='LICENSE_APPFK' object='EIIS.LICENSE_APPS'/>\n" +
"<reference code='EDUPROGRAMFK' object='EIIS.EDUPROGRAMS'/>\n" +
"<column name='Код ОП' code='CODE' type='6' required='1' max='10'/>\n" +
"<column name='Наименование' code='NAME' type='6' required='1' max='3000'/>\n" +
"<reference code='EDULEVELFK' object='EIIS.EDULEVELS'/>\n" +
"<reference code='EDUPROGRAM_TYPEFK' object='EIIS.EDUPROGRAM_TYPES'/>\n" +
"<column name='Нормативный срок обучения' code='PERIOD' type='6' required='1' max='64'/>\n" +
"<column name='Код квалификации' code='QUALIFICATIONCODE' type='6' required='1' max='2'/>\n" +
"<column name='Наименование квалификации' code='QUALIFICATIONNAME' type='6' required='1' max='1500'/>\n" +
"<column name='Присваиваемый квалификационный разряд' code='QUALIFICATIONGRADE' type='6' required='1' max='32'/>\n" +
"<reference code='LICENSE_STATFK' object='EIIS.LICENSE_STATS'/>\n" +
"<column name='Код ОКСО' code='OKSO' type='6' required='1' max='10'/>\n" +
"<column name='ГОС/ФГОС' code='STANDARD_TYPE' type='6' required='1' max='10'/>\n" +
"<column name='Состояние записи ИСЛОД' code='SYS_STATE' type='2' required='1'/>\n" +
"<column name='Дата создания записи ИСЛОД' code='SYS_CREATED' type='5' required='1'/>\n" +
"<column name='Дата обновления записи ИСЛОД' code='SYS_UPDATED' type='5' required='1'/>\n" +
"<column name='ОП по новому справочнику' code='NEW_EDUPROGRAMFK' type='6' required='1' max='50'/>\n" +
"</object>\n" +
"<object name='Типы учредителей ОУ' code='EIIS.FOUNDER_TYPES'>\n" +
"<primary name='Идентификатор' code='ID' type='0'/>\n" +
"<column name='Наименование' code='NAME' type='6' required='1' max='255'/>\n" +
"<column name='Код' code='CODE' type='2' required='1'/>\n" +
"<column name='Не актуально' code='NOT_TRUE' type='1' required='1'/>\n" +
"</object>\n" +
"<\list>"

xml = 
"<object>" +
"<row>\n" +
"<primary code='ID'><![CDATA[2107E3654819FBD7081CDBCBA0B56B5F]]></primary>\n" +
"<column code='ISLOD_GUID'><![CDATA[2107E3654819FBD7081CDBCBA0B56B5F]]></column>\n" +
"<column code='NAME'><![CDATA[государственное образовательное учреждение среднего профессионального образования <Уральский государственный колледж имени И.И. Ползунова>]]></column>\n" +
"<column code='SHORTNAME'><![CDATA[ГОУ СПО <Уральский государственный колледж им. И.И. Ползунова>]]></column>\n" +
"<column code='REGULARNAME'><![CDATA[Уральский государственный колледж имени И.И. Ползунова]]></column>\n" +
"<reference code='SCHOOL_PROPERTYFK' object='EIIS.SCHOOLPROPERTIES'><![CDATA[73875EB8A971AF0F28107418AF199065]]></reference>\n" +
"<reference code='SCHOOL_TYPEFK' object='EIIS.SCHOOL_TYPES'><![CDATA[4FABD21CFE54438F9D7786AF0535B5D7]]></reference>\n" +
"<reference code='SCHOOL_KINDFK' object='EIIS.SCHOOL_KINDS'><![CDATA[NULL]]></reference>\n" +
"<reference code='SCHOOL_CATEGORYFK' object='EIIS.SCHOOL_CATEGORIES'><![CDATA[NULL]]></reference>\n" +
"<column code='BRANCH'><![CDATA[False]]></column>\n" +
"<reference code='PARENTFK' object='EIIS.SCHOOLS'><![CDATA[NULL]]></reference>\n" +
"<column code='HASMILITARYDEPARTMENT'><![CDATA[NULL]]></column>\n" +
"<column code='HASHOSTEL'><![CDATA[NULL]]></column>\n" +
"<column code='HOSTELCAPACITY'><![CDATA[NULL]]></column>\n" +
"<column code='HASHOSTELFORENTRANTS'><![CDATA[NULL]]></column>\n" +
"<column code='LAW_ADDRESS'><![CDATA[620014, Свердловская область, г. Екатеринбург, проспект Ленина, д. 28]]></column>\n" +
"<column code='LAW_POST_INDEX'><![CDATA[NULL]]></column>\n" +
"<column code='LAW_COUNTRYFK'><![CDATA[NULL]]></column>\n" +
"<reference code='LAW_REGIONFK' object='EIIS.REGIONS'><![CDATA[66]]></reference>\n" +
"<reference code='LAW_TOWNTYPEFK' object='EIIS.TOWNTYPES'><![CDATA[NULL]]></reference>\n" +
"<column code='LAW_CITY_NAME'><![CDATA[NULL]]></column>\n" +
"<column code='LAW_STREET'><![CDATA[NULL]]></column>\n" +
"<column code='LAW_HOUSE'><![CDATA[NULL]]></column>\n" +
"<column code='LAW_OFFICE'><![CDATA[NULL]]></column>\n" +
"<column code='ADDRESS'><![CDATA[проспект Ленина, д. 28, г. Екатеринбург, Свердловская область, 620014]]></column>\n" +
"<column code='POST_INDEX'><![CDATA[620014]]></column>\n" +
"<column code='COUNTRYFK'><![CDATA[NULL]]></column>\n" +
"<reference code='REGIONFK' object='EIIS.REGIONS'><![CDATA[66]]></reference>\n"+
"<reference code='TOWNTYPEFK' object='EIIS.TOWNTYPES'><![CDATA[NULL]]></reference>\n" +
"<column code='TOWN_NAME'><![CDATA[NULL]]></column>\n" +
"<column code='STREET'><![CDATA[NULL]]></column>\n" +
"<column code='HOUSE'><![CDATA[NULL]]></column>\n" +
"<column code='OFFICE'><![CDATA[NULL]]></column>\n" +
"<column code='PHONES'><![CDATA[(343)371-89-08]]></column>\n" +
"<column code='FAXS'><![CDATA[(343)371-89-08]]></column>\n" +
"<column code='MAILS'><![CDATA[kp1847@mail.ru]]></column>\n" +
"<column code='WWW'><![CDATA[NULL]]></column>\n" +
"<column code='GOSREGNUM'><![CDATA[1036603989476]]></column>\n" +
"<column code='INN'><![CDATA[6661000628]]></column>\n" +
"<column code='KPP'><![CDATA[NULL]]></column>\n" +
"<column code='CHARGEPOSITION'><![CDATA[Директор]]></column>\n" +
"<column code='CHARGEFIO'><![CDATA[Рыбаков Евгений Аркадьевич]]></column>\n" +
"<column code='CONTACT_FIRST_NAME'><![CDATA[NULL]]></column>\n" +
"<column code='CONTACT_SECOND_NAME'><![CDATA[NULL]]></column>\n" +
"<column code='CONTACT_LAST_NAME'><![CDATA[NULL]]></column>\n" +
"<column code='STUDENTS_COUNT'><![CDATA[0]]></column>\n" +
"<column code='SCHOOLLEAVER_COUNT'><![CDATA[0]]></column>\n" +
"<column code='DATELASTCHECK'><![CDATA[NULL]]></column>\n" +
"<column code='LICENSE_REG_NUM'><![CDATA[NULL]]></column>\n" +
"<column code='LICENSE_DATE_BEGIN'><![CDATA[NULL]]></column>\n" +
"<column code='LICENSE_DATE_END'><![CDATA[NULL]]></column>\n" +
"<column code='SVAKKR_REG_NUM'><![CDATA[NULL]]></column>\n" +
"<column code='SVAKKR_DATE_BEGIN'><![CDATA[NULL]]></column>\n" +
"<column code='SVAKKR_DATE_END'><![CDATA[NULL]]></column>\n" +
"<column code='LICENSE_ADDRESS'><![CDATA[NULL]]></column>\n" +
"<column code='OUTDATED'><![CDATA[True]]></column>\n" +
"<reference code='EX_SCHOOLFK' object='EIIS.SCHOOLS'><![CDATA[NULL]]></reference>\n" +
"<column code='SYS_STATE'><![CDATA[2]]></column>\n" +
"<column code='SYS_CREATED'><![CDATA[14.01.2011 19:14:17]]></column>\n" +
"<column code='SYS_UPDATED'><![CDATA[19.06.2014 17:08:53]]></column>\n" +
"<column code='IMPL_ADDR'><![CDATA[NULL]]></column>\n" +
"<column code='ADDRESS2'><![CDATA[проспект Ленина, д. 28, г. Екатеринбург, Свердловская область, 620014]]></column>\n" +
"<column code='MON_ID'><![CDATA[NULL]]></column>\n" +
"<reference code='STATUS_FK' object='EIIS.SCHOOL_STATUSES'><![CDATA[NOT_VALID]]></reference>\n" +
"<column code='FOUNDERS'><![CDATA[ Министерство образования и науки Российской Федерации; Федеральное агентство научных организаций]]</column>\n" +
"<column code='INSIDE_SCHOOL_FK'><![CDATA[NULL]]></column>\n" +
"<column code='OUTSIDE_SCHOOL_FK'><![CDATA[NULL]]></column>\n" +
"<column code='RENAME'><![CDATA[Государственное образовательное учреждение среднего профессионального образования <Уральский государственный колледж имени И.И.Ползунова>; Государственное образовательное учреждение среднего профессионального образования<Уральский государственный колледж имени И.И. Ползунова> (ГОУ СПО<Уральский государственный колледж им. И.И. Ползунова>)]]></column>\n" +
"<column code='ISSTRONG'><![CDATA[False]]></column>\n" +
"<column code='ISRELIGION'><![CDATA[False]]></column>\n" +
"<column code='GA_GUID'><![CDATA[2107E365-4819-FBD7-081C-DBCBA0B56B5F]]></column>\n" +
"</row>\n" +
"\n" +
"<row>\n" +
"<primary code='ID'><![CDATA[2110DF0645FF28E8BDB534D5FAFB7BC9]]></primary>\n" +
"<column code='ISLOD_GUID'><![CDATA[2110DF0645FF28E8BDB534D5FAFB7BC9]]></column>\n" +
"<column code='NAME'><![CDATA[филиал федерального государственного автономного образовательного учреждения высшего образования <Южный федеральный университет> в г. Махачкале Республики Дагестан]]></column>\n" +
"<column code='SHORTNAME'><![CDATA[филиал ЮФУ в г. Махачкале]]></column>\n" +
"<column code='REGULARNAME'><![CDATA[филиал федерального государственного автономного образовательного учреждения высшего образования <Южный федеральный университет> в г. Махачкале Республики Дагестан]]></column>\n" +
"<reference code='SCHOOL_PROPERTYFK' object='EIIS.SCHOOLPROPERTIES'><![CDATA[1faca2fad9244fb49f9eb33d850de447]]></reference>\n" +
"<reference code='SCHOOL_TYPEFK' object='EIIS.SCHOOL_TYPES'><![CDATA[4e27741606344006ac8a67c91a87d320]]></reference>\n" +
"<reference code='SCHOOL_KINDFK' object='EIIS.SCHOOL_KINDS'><![CDATA[NULL]]></reference>\n" +
"<reference code='SCHOOL_CATEGORYFK' object='EIIS.SCHOOL_CATEGORIES'><![CDATA[NULL]]></reference>\n" +
"<column code='BRANCH'><![CDATA[True]]></column>\n" +
"<reference code='PARENTFK' object='EIIS.SCHOOLS'><![CDATA[4E598AD4441107E06F943394BB22DF45]]></reference>\n" +
"<column code='HASMILITARYDEPARTMENT'><![CDATA[NULL]]></column>\n" +
"<column code='HASHOSTEL'><![CDATA[NULL]]></column>\n" +
"<column code='HOSTELCAPACITY'><![CDATA[NULL]]></column>\n" +
"<column code='HASHOSTELFORENTRANTS'><![CDATA[NULL]]></column>\n" +
"<column code='LAW_ADDRESS'><![CDATA[367013, Республика Дагестан, г. Махачкала,ул. Юсупова, д. 51]]></column>\n" +
"<column code='LAW_POST_INDEX'><![CDATA[367013]]></column>\n" +
"<column code='LAW_COUNTRYFK'><![CDATA[NULL]]></column>\n" +
"<reference code='LAW_REGIONFK' object='EIIS.REGIONS'><![CDATA[5]]></reference>\n" +
"<reference code='LAW_TOWNTYPEFK' object='EIIS.TOWNTYPES'><![CDATA[NULL]]></reference>\n" +
"<column code='LAW_CITY_NAME'><![CDATA[г. Махачкала]]></column>\n" +
"<column code='LAW_STREET'><![CDATA[Студенческий пер.]]></column>\n" +
"<column code='LAW_HOUSE'><![CDATA[д. 3]]></column>\n" +
"<column code='LAW_OFFICE'><![CDATA[NULL]]></column>\n" +
"<column code='ADDRESS'><![CDATA[367013, Республика Дагестан, г. Махачкала, ул.Юсупова, д. 51]]></column>\n" +
"<column code='POST_INDEX'><![CDATA[367013]]></column>\n" +
"<column code='COUNTRYFK'><![CDATA[NULL]]></column>\n" +
"<reference code='REGIONFK' object='EIIS.REGIONS'><![CDATA[5]]></reference>\n" +

"<reference code='TOWNTYPEFK' object='EIIS.TOWNTYPES'><![CDATA[NULL]]></reference>\n" +
"<column code='TOWN_NAME'><![CDATA[г. Махачкала]]></column>\n" +
"<column code='STREET'><![CDATA[Студенческий пер.]]></column>\n" +
"<column code='HOUSE'><![CDATA[д. 3]]></column>\n" +
"<column code='OFFICE'><![CDATA[NULL]]></column>\n" +
"<column code='PHONES'><![CDATA[(8722) 68-13-73, факс (8722) 68-13-73]]></column>\n" +
"<column code='FAXS'><![CDATA[(8722)   68-13-73]]></column>\n" +
"<column code='MAILS'><![CDATA[mahach_f@sfedu.ru ]]></column>\n" +
"<column code='WWW'><![CDATA[NULL]]></column>\n" +
"<column code='GOSREGNUM'><![CDATA[1026103165241]]></column>\n" +
"<column code='INN'><![CDATA[6163027810]]></column>\n" +
"<column code='KPP'><![CDATA[057102001]]></column>\n" +
"<column code='CHARGEPOSITION'><![CDATA[NULL]]></column>\n" +
"<column code='CHARGEFIO'><![CDATA[Эмирбеков Эмирбек Зиядович]]></column>\n" +
"<column code='CONTACT_FIRST_NAME'><![CDATA[NULL]]></column>\n" +
"<column code='CONTACT_SECOND_NAME'><![CDATA[NULL]]></column>\n" +
"<column code='CONTACT_LAST_NAME'><![CDATA[NULL]]></column>\n" +
"<column code='STUDENTS_COUNT'><![CDATA[NULL]]></column>\n" +
"<column code='SCHOOLLEAVER_COUNT'><![CDATA[NULL]]></column>\n" +
"<column code='DATELASTCHECK'><![CDATA[NULL]]></column>\n" +
"<column code='LICENSE_REG_NUM'><![CDATA[NULL]]></column>\n" +
"<column code='LICENSE_DATE_BEGIN'><![CDATA[NULL]]></column>\n" +
"<column code='LICENSE_DATE_END'><![CDATA[NULL]]></column>\n" +
"<column code='SVAKKR_REG_NUM'><![CDATA[NULL]]></column>\n" +
"<column code='SVAKKR_DATE_BEGIN'><![CDATA[NULL]]></column>\n" +
"<column code='SVAKKR_DATE_END'><![CDATA[NULL]]></column>\n" +
"<column code='LICENSE_ADDRESS'><![CDATA[NULL]]></column>\n" +
"<column code='OUTDATED'><![CDATA[False]]></column>\n" +
"<reference code='EX_SCHOOLFK' object='EIIS.SCHOOLS'><![CDATA[NULL]]></reference>\n" +
"<column code='SYS_STATE'><![CDATA[2]]></column>\n" +
"<column code='SYS_CREATED'><![CDATA[14.01.2011 19:14:01]]></column>\n" +
"<column code='SYS_UPDATED'><![CDATA[10.05.2012 15:31:01]]></column>\n" +
"<column code='IMPL_ADDR'><![CDATA[NULL]]></column>\n" +
"<column code='ADDRESS2'><![CDATA[Студенческий пер., д. 3, г. Махачкала, Республика Дагестан, 367013]]></column>\n" +
"<column code='MON_ID'><![CDATA[NULL]]></column>\n" +
"<reference code='STATUS_FK' object='EIIS.SCHOOL_STATUSES'><![CDATA[NOT_VALID]]></reference>\n" +
"<column code='FOUNDERS'><![CDATA[ Министерство образования и науки Российской Федерации]]></column>\n" +
"<column code='INSIDE_SCHOOL_FK'><![CDATA[NULL]]></column>\n" +
"<column code='OUTSIDE_SCHOOL_FK'><![CDATA[NULL]]></column>\n" +
"<column code='RENAME'><![CDATA[Филиал Федерального государственного образовательного учреждения высшего профессионального образования <Южный федеральный университет> в г. Махачкале Республики Дагестан; филиал Федерального государственногообразовательного учреждения высшего профессионального образования <Южный федеральный университет> в г. Махачкале Республики Дагестан]]></column>\n" +
"<column code='ISSTRONG'><![CDATA[False]]></column>\n" +
"<column code='ISRELIGION'><![CDATA[False]]></column>\n" +
"<column code='GA_GUID'><![CDATA[2110DF06-45FF-28E8-BDB5-34D5FAFB7BC9]]></column>\n" +
"</row>\n" +
"\n" +
"</object>"

# EXEC sys.sp_addextendedproperty   
# @name = N'MS_DescriptionExample',   
# @value = N'Street address information for customers, employees, and vendors.',   
# @level0type = N'SCHEMA', @level0name = 'Person',  
# @level1type = N'TABLE',  @level1name = 'Address';  

def ParseObjectsList(xml)
    doc = Nokogiri::Slop(xml)
    all_tables = ""
    all_descriptions = ""
    doc.list.object.each do |object|
        all_tables += ParseObjectToCreateString(object)
        all_desc = ParseObjectToAddDescriptionsString(object)
        all_descriptions += all_desc[0]
        all_descriptions += "----------------------------------------"
        all_descriptions += all_desc[1]
        all_descriptions += "--======================================"
    end
    [all_tables,all_descriptions]
end

def ParseObjectToAddDescriptionsString(object)
    table_name = object.attributes.values.select {|x| x.name == "code"}[0].value.split(".").last
    table_desc = object.attributes.values.select {|x| x.name == "name"}[0].value
    table_description = %Q[
        EXEC sys.sp_addextendedproperty   
        @name = N'MS_Description',   
        @value = N'#{table_desc}',   
        @level0type = N'SCHEMA', @level0name = 'eiis',  
        @level1type = N'TABLE',  @level1name = '#{table_name}';  
    ]
    column_descriptions = ""
    object.elements.each do |element|
        column_name = element.attributes.values.select {|x| x.name == "code"}[0].value
        if element.name == "reference"
            col_desc = element.attributes.values.select {|x| x.name == "object"}[0].value
        else
            col_desc = element.attributes.values.select {|x| x.name == "name"}[0].value
        end
        column_description = %Q[
            EXEC sp_addextendedproperty   
            @name = N'MS_Description', 
            @value = '#{col_desc}',  
            @level0type = N'Schema', @level0name = 'eiis',  
            @level1type = N'Table', @level1name = '#{table_name}',   
            @level2type = N'Column',@level2name = '#{column_name}';  
        ]
        column_descriptions += column_description
        # column_descriptions += "\n"
    end
    [table_description, column_descriptions]
end

def ParseObjectToCreateString(object)
    create_table_string = ""
    # берём последнее слово из тех, что через точку в названии объекта EIIS.EDUPROGRAMS - EDUPROGRAMS
    table_name = object.attributes.values.select {|x| x.name == "code"}[0].value.split(".").last
    create_table_string += "CREATE TABLE [eiis].[#{table_name}](\n"
    column_strings = ""
    object.elements.each do |element|
        column_name = element.attributes['code'].value
        # проходим по всем элементам
        case element.name
        when "primary", "reference"
            column_type = "[nvarchar](max) NULL"
        when "column"
            col_int_type = element.attributes['type'].value
            case col_int_type.to_i
            when 5
                column_type = "[datetime] NULL"
            when 1
                column_type = "[bit] NULL"
            when 2
                column_type = "[int] NULL"
            when 6
                column_type = "[nvarchar](max) NULL"
            end
        end
        column_strings += " [#{column_name}] #{column_type},\n"
    end
    # удаляем последнюю запятую, она лишняя
    column_strings = column_strings[0...column_strings.rindex(",")]
    create_table_string += column_strings
    create_table_string += ");\n"
end

def ParseSimple(xml)
    doc = Nokogiri::Slop(xml)

    # это данные
    result = []
    # это столбцы
    codes = []
    doc.object.row.each do |row|
        # заполняем данные в массив
        result << row.children.text.strip.split("\n")
        # если столбцы не заполнены, заполняем один раз, этого достаточно т.к. все столбцы одинаковы для всех строк
        if codes.empty?
            row.elements.each do |element|
                codes << element.attributes.select {|x| x == "code"}.values[0].value.intern
            end
        end
    end
    result.map! do |x|
        x.map! do |y|
            if y == "False" then
                0
            elsif y == "True" then
                1
            elsif y == "NULL" then
                nil
            else
                y
            end
        end
    end
    [result, codes]
end    

def test
    # a == b
    a, b = 1, 2
end

# pp ParseObjectsList(objectslistxml)[0]
# pp test

pp ParseSimple(xml)
