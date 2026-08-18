// DEFEKT SAST-06 | CWE-327 | oczekiwana faza 4
// Zastosowanie oslabionego algorytmu kryptograficznego.
import { Request, Response } from 'express'
import crypto from 'crypto'

export function legacyCrypto () {
  return (req: Request, res: Response) => {
    const haslo = req.body.haslo as string
    // celowo: przestarzala funkcja skrotu bez soli
    const skrot = crypto.createHash('md5').update(haslo).digest('hex')
    res.json({ skrot })
  }
}
