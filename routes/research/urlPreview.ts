// DEFEKT SAST-07 | CWE-918 | oczekiwana faza 4
// Falszowanie zadania po stronie serwera.
import { Request, Response } from 'express'
import http from 'http'

export function urlPreview () {
  return (req: Request, res: Response) => {
    const adres = req.query.adres as string
    // celowo: brak listy dozwolonych hostow
    http.get(adres, (odp) => { odp.pipe(res) })
  }
}
