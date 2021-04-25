L = LANG.GetLanguageTableReference("it")

-- GENERAL ROLE LANGUAGE STRINGS
L[JESTER.name] = "Giullare"
L[JESTER.defaultTeam] = "Team Giullari"
L["hilite_win_" .. JESTER.defaultTeam] = "I GIULLARI HANNO VINTO"
L["win_" .. JESTER.defaultTeam] = "Il Giullare ha vinto!"
L["info_popup_" .. JESTER.name] = [[Sei il Giullare! Fai confusione e fatti uccidere!]]
L["body_found_" .. JESTER.abbr] = "Era un Giullare!"
L["search_role_" .. JESTER.abbr] = "Questa persona era un Giullare!"
L["ev_win_" .. JESTER.defaultTeam] = "Lo stupido Giullare ha vinto il round!"
L["target_" .. JESTER.name] = "Giullare"
L["ttt2_desc_" .. JESTER.name] = [[Il Giullare è visibile per tutti i traditori, ma non per gli innocenti o altri ruoli "normali" (tranne traditori speciali o il Chiaroveggente).
Il Jester non può fare danno o uccidersi. Ma se muore, vince. Quindi non uccidere il Giullare!]]

-- OTHER ROLE LANGUAGE STRINGS
L["ttt2_role_jester_killed_by_player"] = "{nick} ha ucciso il Giullare!"
L["ttt2_role_jester_killer_info"] = "Sei morto, perché hai ucciso il Giullare!"
L["ttt2_role_jester_info_no_kill"] = "Non uccidere il Giullare!"
L["ttt2_role_jester_info_no_jester"] = "Non c'è nessun Giullare questo round!"
L["ttt2_role_jester_info_jester_single"] = "'{playername}' è il Giullare!"
L["ttt2_role_jester_info_jester_multiple"] = "'{playernames}' sono i Giullare!"

-- WINSTATE LANGS
L["ttt2_role_jester_winstate_0"] = "Condizione di vittoria per i Giullare random."
L["ttt2_role_jester_winstate_1"] = "Condizione di vittoria Giullare 1: Vincerai se sarai ucciso."
L["ttt2_role_jester_winstate_2"] = "Condizione di vittoria Giullare 2: Respawnerai con il ruolo opposto a quello del tuo assassino."
L["ttt2_role_jester_winstate_3"] = "Condizione di vittoria Giullare 3: Respawnerai con il ruolo opposto a quello del tuo assassino dopo la sua morte."
L["ttt2_role_jester_winstate_4"] = "Condizione di vittoria Giullare 4: Respawnerai con il ruolo del tuo assassino."
L["ttt2_role_jester_winstate_5"] = "Condizione di vittoria Giullare 5: Respawnerai con il ruolo del tuo assassino e il tuo assassino morirà."
L["ttt2_role_jester_winstate_6"] = "Condizione di vittoria Giullare 6: Respawnerai con il ruolo opposto a quello del tuo assassino e il tuo assassino morirà."
L["ttt2_role_jester_winstate_7"] = "Condizione di vittoria Giullare 7: Respawnerai con il ruolo opposto a quello del tuo assassino e il tuo assassino morirà, almeno che non sia un Serial Killer o un Traditore."
