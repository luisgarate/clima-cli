# Clima CLI

## Comenzando 🚀

La intención de esta CLI es obtener datos climáticos de ciudades en la provincia de Barcelona

### Pre-requisitos 📋

* Terminal
* Ruby >= 2.6.3
* Thor gem 

### Uso 💻

`ruby cli.rb help`
```
Commands:
  cli.rb eltiempo        # Display the weather
  cli.rb help [COMMAND]  # Describe available commands or one specific command
```
----
`ruby cli.rb help eltiempo`
```
Usage:
  cli.rb eltiempo

Options:
  -t, [--today], [--no-today]    # Diaplay todays weather
      [--av-max], [--no-av-max]  # Diaplay the average maximum temperature during the week
      [--av-min], [--no-av-min]  # Diaplay the average minimum temperature during the week

Display the weather
```



### Ejemplo ⌨️

Para `Sant Fost de Campsentelles`

```
$ ruby cli.rb eltiempo --today 'Sant Fost de Campsentelles'

The actual temperature in Sant Fost de Campsentelles is: 9 °C, Sábado
```
