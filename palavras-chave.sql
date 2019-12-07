select mfk.txt_keyword,
       mfk.txt_internal_name
  from m_form_keywords mfk
 where mfk.txt_internal_name is not NULL
   and mfk.id_language = 3
 order by mfk.txt_internal_name;

select mfkv.txt_keyword,
       mfkv.txt_internal_name
  from m_form_keywords_values mfkv
 where mfkv.txt_internal_name is not NULL
   and mfkv.id_language = 3
 order by mfkv.txt_internal_name;
