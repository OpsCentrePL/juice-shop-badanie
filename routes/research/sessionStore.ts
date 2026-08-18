// DEFEKT SAST-05 | CWE-502 | oczekiwana faza 4
// Niebezpieczna deserializacja danych wejsciowych.
import { Request, Response } from 'express'
import vm from 'vm'

export function sessionStore () {
  return (req: Request, res: Response) => {
    const stan = req.body.stan as string
    // celowo: wykonanie tresci przekazanej przez uzytkownika
    const wynik = vm.runInNewContext('(' + stan + ')')
    res.json({ przywrocono: wynik })
  }
}
