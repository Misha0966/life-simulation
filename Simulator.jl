using CellularAutomata
using Plots

# Создание начального состояния поля
initial_state = rand(Bool, 30, 15)

# Определение функции для определения следующего состояния клетки
function next_state(cell, neighbors)
    num_alive_neighbors = sum(neighbors)
    
    if cell
        return num_alive_neighbors == 2 || num_alive_neighbors == 3
    else
        return num_alive_neighbors == 3
    end
end

# Создание объекта правила для моделирования симуляции
rule = Life(((3,), (2, 3)))

# Запуск симуляции
evolution = CellularAutomaton(rule, initial_state, 100)

# Функция для построения текущего состояния поля
function plot_grid(grid, filename)
    heatmap(grid, c=:grays, ratio=1, colorbar=false, axis=false)
    savefig(filename * ".png")
end

# Отображение анимации симуляции
for i in 1:size(evolution.evolution, 3)
    plot_grid(evolution.evolution[:, :, i], "frame_$i")
    display(heatmap(evolution.evolution[:, :, i], c=:grays, ratio=1, colorbar=false, axis=false))
end

# Вывод сообщения для завершения симуляции
println("Нажмите Ctrl+C, чтобы выйти из симуляции")