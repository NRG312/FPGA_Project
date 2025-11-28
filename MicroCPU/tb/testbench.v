module Testbench();

reg[1:0] sel_reg = 2'b00;
reg[1:0] sel_prog = 2'b00;
wire[7:0] data_out;
reg clk;

cpu CPU(.sel_prog(sel_prog),.sel_reg(sel_reg),.clk(clk),.out(data_out));

initial begin
    clk = 0;
    forever #25 clk = ~clk;
end

initial begin
    sel_prog = 2'b00;
    sel_reg = 2'b01;
    // sel_prog = 2'b01;
    @(posedge clk);
    @(posedge clk);
    @(posedge clk);
    @(posedge clk);
    @(posedge clk);
    @(posedge clk);
    $display("Time=%0t | Data out = %b",$time , data_out);
    $finish;   
end

endmodule



//aktualne zadanie do zrobienia
// 1. ROM

// Tablica pamięci (np. logic[7:0] mem[0:15]) przechowuje instrukcje w postaci binarnej.
// Każda komórka = jedna instrukcja.
// ROM nie wykonuje operacji, tylko dostarcza “co zrobić” CPU.

// 2. Rejestry

// Kilka małych rejestrów (np. R0, R1, R2…), każdy po kilka bitów.
// Trzymają dane tymczasowe potrzebne do operacji (np. liczby do dodawania).
// Możesz mieć też Program Counter (PC), który wskazuje aktualną instrukcję w ROM.

// 3. ALU

// Jedno miejsce, gdzie faktycznie dzieje się dodawanie, odejmowanie, AND, OR itp.
// ALU dostaje dane z rejestrów, wykonuje operację i zwraca wynik.

// 4. Dekoder instrukcji

// Odczytuje słowo z ROM.
// Rozdziela, które bity oznaczają operację, a które rejestry.
// Steruje ALU i rejestrami – mówi np.: “weź R1 i R2, dodaj je, wynik zapisz do R0”.

// 5. Przepływ danych

// Program Counter → wskazuje adres w ROM → pobiera instrukcję.
// Dekoder interpretuje instrukcję → wybiera rejestry i operację.
// Dane z rejestrów trafiają do ALU → ALU wykonuje operację.
// Wynik wraca do rejestru lub innego miejsca docelowego.
// Program Counter zwiększa się → następna instrukcja.


// w skrocie

// Program Counter (PC) → wysyła adres następnej instrukcji do ROM.(tutaj testbench jako PC)
// ROM → zwraca instrukcję (opcode + argumenty).
// CPU / Decoder → rozkłada instrukcję, np. „ADD R1, R2”.
// Rejestry / RAM → dostarczają dane (np. zawartość R1 i R2).
// ALU → wykonuje operację (np. dodaje R1 + R2).
// CPU → odbiera wynik i:
// zapisuje go z powrotem do rejestru lub
// wysyła do RAM, jeśli to np. zapis do pamięci.
// Potem PC zwiększa adres i cykl powtarza się