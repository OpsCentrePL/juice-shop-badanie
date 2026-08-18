// DEFEKT SAST-08 | CWE-601 | oczekiwana faza 4
// Niekontrolowane przekierowanie na adres z parametru.
import { Request, Response } from 'express'

export function redirectHandler () {
  return (req: Request, res: Response) => {
    // celowo: brak walidacji domeny docelowej
    res.redirect(req.query.dokad as string)
  }
}
