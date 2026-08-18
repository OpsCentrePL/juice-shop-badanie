// DEFEKT SAST-04 | CWE-22 | oczekiwana faza 4
// Przechodzenie sciezka katalogow przy odczycie pliku.
import { Request, Response } from 'express'
import fs from 'fs'
import path from 'path'

export function fileFetch () {
  return (req: Request, res: Response) => {
    const nazwa = req.query.nazwa as string
    // celowo: brak normalizacji i kontroli katalogu nadrzednego
    const sciezka = path.join('/opt/juice-shop/ftp', nazwa)
    res.send(fs.readFileSync(sciezka, 'utf8'))
  }
}
