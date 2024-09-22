//
//  ViewController.swift
//  TechnicalTest
//
//  Created by Vicky Irwanto on 22/09/24.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Perbedaan let dan var
    let name: String = "Vicky Irwanto" // let adalah immutable variabel yang artinya value dari variabel tidak bisa di ubah.
    var nama: String = "Vicky Irwanto" // var adalah mutable variabe yang artinya value dari variabel bisa di ubah - ubah.

    // MARK: - Lazy Property
    lazy var lazyLabel: UILabel = {
        let label = UILabel()
        label.text = "Ini adalah lazy label"
        label.textColor = .white
        return label
    }()
    
    var secondVC: SecondViewController?
    
    // MARK: - UIKIT Lifecycle
    
    override func loadView() {
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .blue
//        view.addSubview(lazyLabel)
//        lazyLabel.translatesAutoresizingMaskIntoConstraints = false
//        lazyLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        lazyLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        asynchronousTask()
        synchronousTask()
        
        let button = UIButton(type: .system)
        button.setTitle("Go to Second VC", for: .normal)
        button.backgroundColor = .white
        button.addTarget(self, action: #selector(navigateToSecondVC), for: .touchUpInside)
        button.frame = CGRect(x: 100, y: 200, width: 200, height: 50)
        view.addSubview(button)
    }
    
    @objc func navigateToSecondVC() {
        let secondVC = SecondViewController()
        secondVC.firstVC = self // Strong reference to FirstViewController
        self.secondVC = secondVC // Strong reference to SecondViewController
        
        navigationController?.pushViewController(secondVC, animated: true)
    }
    
    // MARK: - viewWillAppear
    // Dipanggil tepat sebelum view muncul di layar. Cocok untuk update UI atau fetch data yang perlu diperbarui.
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear - View akan muncul")
    }
    
    // MARK: - viewDidAppear
    // Dipanggil tepat setelah view muncul di layar. Biasanya digunakan untuk memulai animasi atau tracking event tertentu.
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("viewDidAppear - View sudah muncul")
    }
    
    // MARK: - viewWillDisappear
    // Dipanggil tepat sebelum view menghilang dari layar. Bisa digunakan untuk menyimpan perubahan atau menghentikan proses yang tidak perlu ketika view akan dihilangkan.
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("viewWillDisappear - View akan menghilang")
    }
    
    // MARK: - viewDidDisappear
    // Dipanggil setelah view benar-benar menghilang dari layar. Biasanya digunakan untuk membersihkan resource atau menyetop proses background.
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("viewDidDisappear - View sudah menghilang")
    }
    
    // MARK: - viewWillLayoutSubviews
    // Dipanggil setiap kali sebelum subview diatur ulang oleh sistem. Cocok untuk memperbarui constraint atau layout yang dinamis.
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        print("viewWillLayoutSubviews - Subview akan diatur ulang")
    }
    
    // MARK: - viewDidLayoutSubviews
    // Dipanggil setelah semua subview diatur ulang. Bisa digunakan untuk melakukan penyesuaian akhir pada posisi atau ukuran view.
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print("viewDidLayoutSubviews - Subview telah diatur ulang")
    }
    
    // MARK: - didReceiveMemoryWarning
    // Dipanggil saat aplikasi mendekati batas memori yang dapat digunakan. Cocok untuk membersihkan resource atau cache yang tidak diperlukan.
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        print("didReceiveMemoryWarning - Memori hampir habis")
    }
    
    // MARK: - deinit
    // Dipanggil ketika instance dari view controller dihapus dari memori. Cocok untuk membersihkan resource atau menghentikan observer.
    deinit {
        print("deinit - ViewController telah dihapus dari memori")
    }
    
    // MARK: - Optional
    var optionalString: String?
    
    func checkOptional() {
        // MARK: - Guard statement untuk optional
        guard let unwrappedString = optionalString else {
            print("Optional nil!")
            return
        }
        print("Optional ter-unwrapping: \(unwrappedString)")
    }
    
    // MARK: - Transfer data antara view controllers
    func transferDataToNextViewController() {
        let nextViewController = NextViewController()
        nextViewController.receivedData = "Data yang dikirim"
        present(nextViewController, animated: true, completion: nil)
    }
    
    // MARK: - Struct vs Class
    struct PersonStruct {
        var name: String
    }
    
    class PersonClass {
        var name: String
        init(name: String) {
            self.name = name
        }
    }
    
    func compareStructAndClass() {
        var structPerson = PersonStruct(name: "Struct Person")
        let classPerson = PersonClass(name: "Class Person")
        
        structPerson.name = "Struct Person Baru" // Ini mengubah data pada struct.
        classPerson.name = "Class Person Baru" // Ini mengubah data pada class (referensi yang sama).
        
        print("Struct Person: \(structPerson.name)")
        print("Class Person: \(classPerson.name)")
    }
    
    // MARK: - Closure
    func useClosure(completion: (String) -> Void) {
        completion("Ini closure!")
    }
    
    func testClosure() {
        useClosure { result in
            print(result)
        }
    }
    
    // MARK: - Delegate Pattern
    var delegate: CustomDelegate?
    
    func useDelegate() {
        delegate?.didReceiveData(data: "Data dari delegate")
    }
    
    // MARK: - Memory Management dengan weak dan unowned
    class A {
        var b: B?
        deinit {
            print("A deinit")
        }
    }

    class B {
        weak var a: A? // Menggunakan weak untuk menghindari retain cycle
        deinit {
            print("B deinit")
        }
    }
    
    func manageMemory() {
        var objA: A? = A()
        var objB: B? = B()
        objA?.b = objB
        objB?.a = objA
        objA = nil
        objB = nil
    }
    
    // Contoh penggunaan yang menyebabkan memory leak
    func createMemoryLeak() {
        let objA = A() // Membuat instance A
        let objB = B() // Membuat instance B
        
        objA.b = objB // A memiliki referensi ke B (strong reference)
        objB.a = objA // B memiliki referensi ke A (strong reference)
        
        // Di akhir fungsi, referensi objA dan objB akan hilang,
        // namun karena keduanya saling mereferensikan dengan strong reference,
        // tidak ada dari mereka yang akan dibebaskan oleh ARC.
    }
    
    // MARK: - Synchronous dan Asynchronous
    func synchronousTask() {
        print("Synchronous task mulai")
        sleep(2)
        print("Synchronous task selesai")
    }
    
    func asynchronousTask() {
        DispatchQueue.global().async {
            print("Asynchronous task mulai")
            sleep(2)
            print("Asynchronous task selesai")
        }
    }
    
    // MARK: - Auto Layout dengan programmatic constraint
    func setupAutoLayout() {
        let viewA = UIView()
        viewA.backgroundColor = .red
        view.addSubview(viewA)
        viewA.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            viewA.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            viewA.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            viewA.widthAnchor.constraint(equalToConstant: 100),
            viewA.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
}

// MARK: - Delegate Protocol
protocol CustomDelegate {
    func didReceiveData(data: String)
}

class NextViewController: UIViewController {
    var receivedData: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        if let data = receivedData {
            print("Data diterima: \(data)")
        }
    }
}

class SecondViewController: UIViewController {
    
    var firstVC: ViewController? // Strong reference to FirstViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        
        let button = UIButton(type: .system)
        button.setTitle("Go back to First VC", for: .normal)
        button.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        button.frame = CGRect(x: 100, y: 200, width: 200, height: 50)
        view.addSubview(button)
    }
    
    @objc func goBack() {
        navigationController?.popViewController(animated: true)
    }
    
    deinit {
        print("SecondViewController deinit")
    }
}

