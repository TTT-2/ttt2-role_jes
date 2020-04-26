L = LANG.GetLanguageTableReference("italiano")

-- GENERAL ROLE LANGUAGE STRINGS
L[JESTER.name] = "Jester"
L[JESTER.defaultTeam] = "TEAM Jester"
L["hilite_win_" .. JESTER.defaultTeam] = "I JESTER HANNO VINTO"
L["win_" .. JESTER.defaultTeam] = "Il Jester ha vinto!"
L["info_popup_" .. JESTER.name] = [[Sei il JESTER! Fai confusione e fatti uccidere!]]
L["body_found_" .. JESTER.abbr] = "Era un Jester!"
L["search_role_" .. JESTER.abbr] = "Questa persona era un Jester!"
L["ev_win_" .. JESTER.defaultTeam] = "Lo stupido Jester ha vinto il round!"
L["target_" .. JESTER.name] = "Jester"
L["ttt2_desc_" .. JESTER.name] = [[Il Jester è visibile per tutti i traditori, ma non per gli innocenti o altri ruoli "normali" (tranne traditori speciali o il Chiaroveggente).
Il Jester non può fare danno o uccidersi. Ma se muore, vince. Quindi non uccidere il Jester!]]

-- OTHER ROLE LANGUAGE STRINGS
L["ttt2_role_jester_killed_by_player"] = "{nick} ha ucciso il Jester!"
L["ttt2_role_jester_killer_info"] = "Sei morto, perché hai ucciso il Jester!"
L["ttt2_role_jester_info_no_kill"] = "Non uccidere il Jester!"
L["ttt2_role_jester_info_no_jester"] = "Non c'è nessun Jester questo round!"
L["ttt2_role_jester_info_jester_single"] = "'{playername}' è il Jester!"
L["ttt2_role_jester_info_jester_multiple"] = "'{playernames}' sono i Jester!"

-- WINSTATE LANGS
L["ttt2_role_jester_winstate_0"] = "Condizione di vittoria per i Jester random."
L["ttt2_role_jester_winstate_1"] = "Condizione di vittoria Jester 1: Vincerai se sarai ucciso."
L["ttt2_role_jester_winstate_2"] = "Condizione di vittoria Jester 2: Respawnerai con il ruolo opposto a quello del tuo assassino."
L["ttt2_role_jester_winstate_3"] = "Condizione di vittoria Jester 3: Respawnerai con il ruolo opposto a quello del tuo assassino dopo la sua morte."
L["ttt2_role_jester_winstate_4"] = "Condizione di vittoria Jester 4: Respawnerai con il ruolo del tuo assassino."
L["ttt2_role_jester_winstate_5"] = "Condizione di vittoria Jester 5: Respawnerai con il ruolo del tuo assassino e il tuo assassino morirà."
L["ttt2_role_jester_winstate_6"] = "Condizione di vittoria Jester 6: Respawnerai con il ruolo opposto a quello del tuo assassino e il tuo assassino morirà."
L["ttt2_role_jester_winstate_7"] = "Condizione di vittoria Jester 7: Respawnerai con il ruolo opposto a quello del tuo assassino e il tuo assassino morirà, almeno che non sia un Serial Killer o un Traditore."
