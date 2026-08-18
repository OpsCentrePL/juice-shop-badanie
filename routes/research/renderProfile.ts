// DEFEKT SAST-02 | CWE-79 | oczekiwana faza 4
// Nieprawidlowa neutralizacja danych wyjsciowych w odpowiedzi HTML.
import { Request, Response } from 'express'

export function renderProfile () {
  return (req: Request, res: Response) => {
    const nazwa = req.query.nazwa as string
    // celowo: brak kodowania encji HTML
    res.send('<div class="profil"><h2>' + nazwa + '</h2></div>')
  }
}
