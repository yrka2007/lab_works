uses GraphABC, HarterHeighway;

const
  InitialDepth = 10;
  InitialLength = 300;

var
  dragonPoints: List<(real, real)>;
  scale: real = 1.0;
  offsetX: real = 0.0; // Разделяем инициализацию
  offsetY: real = 0.0; // Разделяем инициализацию
  depth: integer = InitialDepth;

// Переменные для перемещения мышью
var
  isDragging: boolean = false;
  lastX, lastY: integer;

// Процедура перерисовки фрактала
procedure Redraw;
var
  i: integer;
begin
  ClearWindow;
  
  // Генерируем точки фрактала с центром в (0,0)
  dragonPoints := GenerateDragonPoints(0, 0, InitialLength, -Pi / 2, depth);
  
  // Рисуем ломаную линию с учетом масштаба и смещения окна
  for i := 1 to dragonPoints.Count - 1 do
    Line(
      Round(dragonPoints[i - 1].Item1 * scale + Window.Width / 2 + offsetX),
      Round(dragonPoints[i - 1].Item2 * scale + Window.Height / 2 + offsetY),
      Round(dragonPoints[i].Item1 * scale + Window.Width / 2 + offsetX),
      Round(dragonPoints[i].Item2 * scale + Window.Height / 2 + offsetY));
end;

// Обработка нажатий клавиш (масштабирование и глубина)
procedure KeyDown(key: integer);
begin
  case key of
    VK_UP:   depth := Min(depth + 1, 15); // Увеличить глубину (детализацию)
    VK_DOWN: depth := Max(depth - 1, 0);   // Уменьшить глубину
    VK_LEFT: scale := scale * 1.1;         // Приблизить (увеличить масштаб)
    VK_RIGHT: scale := scale / 1.1;         // Отдалить (уменьшить масштаб)
  else exit; // Если нажата другая клавиша, ничего не делаем
  end;
  Redraw; // Перерисовываем после любого изменения
end;

// --- Обработка событий мыши ---
procedure MouseDown(x, y, mb: integer);
begin
  if mb = 1 then // Проверяем левую кнопку мыши (mb=1)
  begin
    isDragging := true;
    lastX := x;
    lastY := y;
  end;
end;

procedure MouseMove(x, y, mb: integer);
begin
  if isDragging then
  begin
    offsetX += x - lastX; 
    offsetY += y - lastY; 
    lastX := x;
    lastY := y;
    Redraw; // Перерисовываем при движении для плавности
  end;
end;

procedure MouseUp(x, y, mb: integer);
begin
  if mb = 1 then // Отпускание левой кнопки завершает перемещение
    isDragging := false;
end;
// ---

begin // Начало основной программы
  
  SetWindowSize(1920, 1200);
  SetWindowCaption('Кривая Хартера-Хейтуэя');
  CenterWindow; // Центрируем окно на экране
  
  // Назначаем обработчики событий
  OnKeyDown := KeyDown;
  OnMouseDown := MouseDown;
  OnMouseMove := MouseMove;
  OnMouseUp := MouseUp;
  
  Redraw; // Первоначальный вывод фрактала
  
end.