local L = LANG.GetLanguageTableReference ("tr")

-- GENERAL ROLE LANGUAGE STRINGS
L[roles.JESTER.name] = "Soytarı"
L[roles.JESTER.defaultTeam] = "Soytarı Takımı"
L["hilite_win_" .. roles.JESTER.defaultTeam] = "SOYTARI TAKIMI KAZANDI"
L["win_" .. roles.JESTER.defaultTeam] = "Soytarılar kazandı!"
L["info_popup_" .. roles.JESTER.name] = [[Soytarısın! Sorun çıkar ve seni öldürmelerine izin ver!]]
L["body_found_" .. roles.JESTER.abbr] = "Onlar bir Soytarıydı!"
L["search_role_" .. roles.JESTER.abbr] = "Bu kişi bir Soytarıydı!"
L[" ev_win_ " .. roles.JESTER.defaultTeam] = "Aptal Soytarı raundu kazandı!"
L["target_" .. roles.JESTER.name] = "Soytarı"
L["ttt2_desc_" .. roles.JESTER.name] = [[Soytarı herhangi bir hain için görünür, ancak masumlar veya diğer "normal" roller için görünmezdir (özel hain rolleri veya Kâhin hariç).
Soytarı herhangi bir hasar veremez veya kendini öldüremez ama ölürse KAZANIR. Bu yüzden Soytarıyı öldürme!]]

-- OTHER ROLE LANGUAGE STRINGS
L["ttt2_role_jester_info_no_kill"] = "Soytarıyı öldürme!"
L["ttt2_role_jester_info_no_jester"] = "Bu rauntta Soytarı yok!"
L["ttt2_role_jester_info_jester_single"] = "'{playername}' adlı oyuncu Soytarı!"
L["ttt2_role_jester_info_jester_multiple"] = "'{playernames}' adlı oyuncular Soytarı!"

L["title_event_jester_kill"] = "Bir Soytarı öldürüldü"
L["desc_event_jester_kill"] = "{jester} Soytarı tetikçi bir {killer} ({role} / {team}) tarafından öldürüldü."
L["tooltip_jester_kill_score_jester"] = "Soytarı öldürme bonusu: {score}"
L["jester_kill_score_jester"] = "Soytarı öldürme bonusu:"
L["tooltip_jester_kill_score_killer"] = "Soytarı öldürme cezası: {score}"
L["jester_kill_score_killer"] = "Soytarı öldürme cezası:"

L["label_jes_announce"] = "Bir Soytarı raunttaysa duyur"
L["label_jes_improvised"] = "Soytarı diğer oyuncuları ittirebilir"
L["label_jes_carry"] = "Soytarı, manyeto çubuğu ile varlıkları alabilir"
L["label_jes_ignitedmg"] = "Soytarı yanma hasarı alabilir"
L["label_jes_explosiondmg"] = "Soytarı patlama hasarı alabilir"
L["label_jes_exppose_to_all_evils"] = "Rollerini tüm kötü rollere maruz bırakır"
