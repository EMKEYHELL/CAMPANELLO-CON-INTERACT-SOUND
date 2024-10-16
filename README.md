# FiveM ESX Campanello con InteractSound

![Banner](https://r2.fivemanage.com/pub/nyuum6mnflaq.png)

Questo script è progettato per il tuo server FiveM basato su ESX e implementa un sistema di campanelli con notifiche sonore e visive. Gli utenti possono interagire con i campanelli situati in punti specifici sulla mappa, e il suono del campanello viene inviato al giocatore con un lavoro associato, tramite **InteractSound**.

**Nota**: Questa è una **versione di prova** adattata specificamente al mio server **Soulshrine** e non è "plug and play" a meno che non sappiate dove mettere le mani per modificare le notifiche a schermo. Una versione standalone sarà disponibile in futuro!

## Caratteristiche

- **Interazione con Campanelli**: I giocatori possono suonare campanelli posizionati in varie location.
- **Notifiche Personalizzate**: Messaggi di conferma su schermo tramite il sistema `vms_notify` con icone e colori personalizzati.
- **Supporto a InteractSound**: Suoni personalizzati per i campanelli.
- **Compatibile con ESX**: Invia notifiche ai giocatori con lavori specifici quando il campanello viene suonato.

## Installazione

1. Scarica e copia tutti i file in una cartella all'interno della directory `resources` del tuo server.
2. Aggiungi la risorsa al file `server.cfg`:
    ```bash
    ensure campanello
    ```
3. Configura i campanelli nel file `config.lua` aggiungendo le coordinate e i dettagli per ogni location.
4. **Installazione di InteractSound**: Lo script richiede **InteractSound** per riprodurre suoni nei campanelli. Puoi scaricare **InteractSound** da [questo link](https://github.com/plunkettscott/InteractSound). Questo script è stato creato da [Scott Plunkett](https://github.com/plunkettscott).

## Configurazione

All'interno del file `config.lua`, puoi configurare:

- **Coords**: Coordinate per ogni campanello.
- **Lavoro**: Lavoro associato al campanello (il giocatore con quel lavoro riceverà la notifica).
- **Suono**: Il file sonoro che viene riprodotto quando il campanello viene suonato.
- **Marker**: Dimensioni e colore del marker visualizzato sopra il campanello.

Esempio di configurazione:
```lua
{
    coords = vector3(-822.34, -700.56, 28.06),
    lavoro = 'police',
    suono = 'doorbell',
    text = 'Stazione di Polizia',
    markerScale = 1.0,
    markerColor = { r = 255, g = 0, b = 0, a = 50 }
}
```

## Impostare le Notifiche di Base

Se desideri rimuovere le notifiche personalizzate (`vms_notify`) e sostituirle con le notifiche ESX di base, puoi modificare i seguenti punti nel codice:

### Client-side (file `client.lua`)

Sostituisci la riga:
```lua
exports['vms_notify']:Notification("Campanello", "~g~Hai suonato il campanello!", 2000, '#00ff00', 'fa-check')
```
Con:

```lua
ESX.ShowNotification("~g~Hai suonato il campanello!")
```
### Server-side (file server.lua)

Sostituisci tutte le righe:

```lua
TriggerClientEvent('vms_notify:Notification', xPlayers[i], 'Campanello', '~g~Qualcuno ha suonato il campanello!', 2000, '#ff9900', 'fa-exclamation-triangle')
```
con:

```lua
TriggerClientEvent('esx:showNotification', xPlayers[i], '~g~Qualcuno ha suonato il campanello!')
```
Mantieni comunque l'integrazione con InteractSound sia nel client che nel server,gestisce l'audio dei campanelli. Non modificare le righe che coinvolgono:

```lua
TriggerServerEvent('InteractSound_SV:PlayOnSource', campanello.suono, 0.5)
```

```lua
TriggerClientEvent('InteractSound_SV:PlayOnSource', xPlayers[i], campanello.suono, 0.5)
```

## Contatti

Per eventuali suggerimenti o domande, contattami su:

- **GitHub**: [emkeyhell](https://github.com/emkeyhell)
- **Email**: emkeyhell@gmail.com
- **Discord**: [Unisciti al Discord](https://discord.gg/jjsQU2bFBP)
- **Twitch**: [emkeyhell su Twitch](https://www.twitch.tv/emkeyhell)
- **Instagram**: [emkeyhell su Instagram](https://www.instagram.com/emkeyhell)

## Contribuire

Se desideri contribuire, sentiti libero di aprire una pull request o segnalare eventuali bug. Ogni contributo è ben accetto!






